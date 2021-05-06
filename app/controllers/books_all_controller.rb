class BooksAllController < ApplicationController
  def index
      @users = User.all
  end

  private

end

def books_year
  require "time"
  time_now = Time.new
  month  = time_now.month
  if month == 7 ||  month == 8 || month == 9 || month == 11 || month == 12
  time_now.year
  else
  time_now.year - 1
  end
end

def book_expenses_same(user_id)
  require "time"
  time_now = Time.new
  month  = time_now.month
  if month == 7 ||  month == 8 || month == 9 || month == 10 || month == 11 || month == 12
  time_a =Time.zone.parse("#{time_now.year}-07-01")
  @books = Book.where(user_id:user_id ).where(purchase_date: time_a..time_now)
  else
  time_b = Time.zone.parse("#{time_now.year - 1}-07-01")
  @books = Book.where(user_id: user_id).where(purchase_date: time_b..time_now)
  end
  num = 0
  @books.each do |book|
    num += book.price
  end
  num
end
