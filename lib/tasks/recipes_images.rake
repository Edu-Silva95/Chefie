# frozen_string_literal: true

namespace :recipes do
  desc "Attach existing images from app/assets/images to recipes by title"
  task attach_images: :environment do
    image_map = {
      "Greek Salad" => "Greek_Salad.png",
      "Pesto Pasta" => "Pesto_Pasta.png",
      "Pepperoni Pizza" => "Pepperoni_Pizza.png",
      "Strawberry Daiquiri" => "Strawberry_Daquiri.png"
    }

    attached = 0
    skipped = 0
    missing = 0

    image_map.each do |title, filename|
      recipe = Recipe.find_by(title: title)
      unless recipe
        puts "[missing recipe] #{title}"
        missing += 1
        next
      end

      if recipe.image.attached?
        puts "[skipped] #{title} already has an image"
        skipped += 1
        next
      end

      image_path = Rails.root.join("app/assets/images", filename)
      unless File.exist?(image_path)
        puts "[missing file] #{image_path}"
        missing += 1
        next
      end

      recipe.image.attach(io: File.open(image_path), filename: filename)
      puts "[attached] #{title} -> #{filename}"
      attached += 1
    end

    puts "Done. attached=#{attached} skipped=#{skipped} missing=#{missing}"
  end
end
