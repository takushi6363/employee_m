class BooksController < ApplicationController

def index
  @user = User.find(params[:user_id])
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
  @user = User.find(params[:user_id])
  @time_year = Time.new.year
   if params[:year] == ""
    @books_all = Book.where(user_id: params[:user_id]).order(purchase_date: :desc)
   else
    @year = params[:year].to_i
    time_a =Time.zone.parse("#{@year - 1 }-07-01")
    time_b =Time.zone.parse("#{@year}-06-30")
    @books_all = Book.where(user_id: params[:user_id]).where(purchase_date: time_a..time_b).order(purchase_date: :desc)
   end
   render template: "books/index"
end

    private

    def book_params
      params.permit(:price,:purchase_date).merge(user_id: @user.id)
    end

end

def book_expenses_same_one
  require "time"
  time_now = Time.new
  month  = time_now.month
  if month == 7 ||  month == 8 || month == 9 || month == 10 ||month == 11 || month == 12
  time_a =Time.zone.parse("#{time_now.year}-07-01")
  @books = Book.where(user_id: params[:user_id]).where(purchase_date: time_a..time_now).order(purchase_date: :desc)
  else
  time_b = Time.zone.parse("#{time_now.year - 1}-07-01")
  @books = Book.where(user_id: params[:user_id]).where(purchase_date: time_b..time_now).order(purchase_date: :desc)
  end
  num = 0
  @books.each do |book|
    num += book.price
  end
  num
end

def book_balance
  30000 - book_expenses_same_one
end


