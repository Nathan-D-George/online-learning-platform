class AboutController < ApplicationController
  def new
    flash[:notice] = 'got to about page okay'
  end
end
