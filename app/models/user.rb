class User < ApplicationRecord
  has_many :user_years
  has_many :estimates
end
