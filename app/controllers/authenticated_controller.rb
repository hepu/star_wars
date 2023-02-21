class AuthenticatedController < ApplicationController
  before_action :validate_user!
end
