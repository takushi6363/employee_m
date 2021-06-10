class HomesController < ApplicationController
  def index
    @books = Book.where(user_id: params[:user_id])
    @time_year = Time.new.year
  end
end
