class User < ApplicationRecord
  has_many :books
  attr_encrypted :my_number, key: 'This is a key that is 256 bits!!'

end
