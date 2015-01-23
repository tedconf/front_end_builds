class WelcomeController < ApplicationController
  def index
    render file: 'public/test.html'
  end
end
