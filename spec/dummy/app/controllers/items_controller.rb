class ItemsController < ApplicationController
  def show
    respond_to do |format|
      format.json { render json: { it: :worked } }
    end
  end
end
