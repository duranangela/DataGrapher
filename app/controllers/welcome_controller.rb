class WelcomeController < ApplicationController

  def index
    @states = StateName.all.pluck(:name)
  end

end
