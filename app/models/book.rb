class Book < ApplicationRecord
  belongs_to :user

  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :purchase_date, presence: true


  def self.books_year
    time_now = Time.new
    month = time_now.month
    if month.between?(7, 12)
      time_now.year
    else
      time_now.year - 1
    end
  end

  def self.books_times(user_id)
    time_now = Time.new
    month = time_now.month
    if month.between?(7, 12)
      time_a = Time.zone.parse("#{time_now.year}-07-01")
      @books = Book.where(user_id: user_id).where(purchase_date: time_a..time_now).order(purchase_date: :desc)
    else
      time_b = Time.zone.parse("#{time_now.year - 1}-07-01")
      @books = Book.where(user_id: user_id).where(purchase_date: time_b..time_now).order(purchase_date: :desc)
    end
  end

  def self.book_expenses_same_one
    num = 0
    @books.each do |book|
      num += book.price
    end
    num
  end

  def self.book_balance
    30_000 - book_expenses_same_one
  end
end
