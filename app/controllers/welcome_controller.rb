class WelcomeController < ApplicationController
  before_action :set_auth

  def index
    @states = StateName.all.pluck(:name)
  end

  private

  def set_auth
    @auth = session[:omniauth] if session[:omniauth]
  end

end
