module Users
  class RegistrationsController < Devise::RegistrationsController
    protected

    def after_update_path_for(resource)
      dashboard_index_path
    end
  end
end
