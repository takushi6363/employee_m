class BooksController < ApplicationController
  before_action :user_set_up, only: [:index, :create, :search]
  before_action :set_up, only: [:index, :create, :search]

  def index
    @books_all = Book.where(user_id: params[:user_id]).order(purchase_date: :desc)
    @time_year = Time.new.year
  end

  def create
    @user = User.find(params[:user_id])
    @book = @user.books.new(book_params)
    @book.save
    redirect_to user_books_path(@user.id)
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to user_books_path(book.user_id)
  end

  def search
    @time_year = Time.new.year
    if params[:year] == ''
      @books_all = Book.where(user_id: params[:user_id]).order(purchase_date: :desc)
    else
      @year = params[:year].to_i
      time_a = Time.zone.parse("#{@year}-07-01")
      time_b = Time.zone.parse("#{@year + 1}-06-30")
      @books_all = Book.where(user_id: params[:user_id]).where(purchase_date: time_a..time_b).order(purchase_date: :desc)
    end
    render template: 'books/index'
  end

  private

  def set_up
    @books = Book.books_times(@user.id)
  end

  def user_set_up
    @user = User.find(params[:user_id])
  end

  def book_params
    params.permit(:price, :purchase_date).merge(user_id: @user.id)
  end
end
