class Payment < ApplicationRecord
  belongs_to :user
  enum status: { empty: 0, in_process: 5, paid: 10, canceled: 15 }
end
