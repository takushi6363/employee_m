class BooksAllController < ApplicationController
  def index
      @users = User.all
  end
end
