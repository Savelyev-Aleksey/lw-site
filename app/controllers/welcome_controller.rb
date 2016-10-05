class WelcomeController < ApplicationController
  def index
    render :index, layout: 'welcome'
  end

  def about
    render :about, layout: 'application'
  end
end
