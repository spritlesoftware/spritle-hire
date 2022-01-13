class RegistrationsController < Devise::RegistrationsController
  layout "application", only: [ :edit, :update ]
end
