# -----------------------------
# Stage 1: Base
# -----------------------------
ARG RUBY_VERSION=3.1.4
FROM ruby:${RUBY_VERSION}-slim AS base

LABEL fly_launch_runtime="rails"

WORKDIR /app

# Runtime dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      curl libjemalloc2 libvips postgresql-client imagemagick python3 \
      build-essential libpq-dev libffi-dev libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists/*

# Install Node 20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

ENV RAILS_ENV=production
ENV NODE_ENV=production
ENV BUNDLE_DEPLOYMENT=1
ENV BUNDLE_PATH=/usr/local/bundle
ENV BUNDLE_WITHOUT="development:test"

# -----------------------------
# Stage 2: Build
# -----------------------------
FROM base AS build

# Install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && \
    bundle install --jobs 4 --retry 3

# Install Node dependencies if package.json exists
COPY package.json package-lock.json* ./
RUN if [ -f package.json ]; then npm install --production; fi

# Copy app
COPY . .

# Copy seed images so they are available for db:seed
COPY db/seeds/images /app/db/seeds/images

# Bootsnap
RUN bundle exec bootsnap precompile app/ lib/

# Assets
ARG SECRET_KEY_BASE=dummy
ENV DATABASE_URL=postgres://dummy:dummy@localhost:5432/dummy_db
RUN SECRET_KEY_BASE=$SECRET_KEY_BASE \
    DISABLE_DATABASE_ENVIRONMENT_CHECK=1 \
    bundle exec rails assets:precompile

# -----------------------------
# Stage 3: Final Image
# -----------------------------
FROM base

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /app /app

WORKDIR /app

RUN chmod +x bin/*

RUN groupadd --system --gid 1000 rails && \
    useradd --uid 1000 --gid 1000 --create-home --shell /bin/bash rails && \
    chown -R rails:rails /app

USER rails

EXPOSE 8080

CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "8080"]