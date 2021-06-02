class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :working_days
  has_many :books
  has_many :vacations

  validates :name, presence: true
  validates :joining_day, presence: true
  validates :working_days_id, numericality: { other_than: 1, message: 'を選択して下さい' }
end
