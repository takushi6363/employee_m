class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :working_days
  has_many :books

  validates :name, presence: true
  validates :working_days_id, numericality: { other_than: 1 } 

  attr_encrypted :my_number, key: 'This is a key that is 256 bits!!'

end
