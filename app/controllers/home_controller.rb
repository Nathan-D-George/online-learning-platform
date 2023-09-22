class HomeController < ApplicationController
  def new
    @courses = Course.all
  end
end
