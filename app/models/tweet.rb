class Tweet < ApplicationRecord
  
  validates :message, length: { maximum: 140 }

  belongs_to :user
end
