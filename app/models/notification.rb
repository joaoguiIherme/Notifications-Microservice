class Notification < ApplicationRecord
  validates :task_id, presence: true, numericality: { only_integer: true, message: "must be an integer" }
  validates :event_type, presence: { message: "can't be blank" }
  validates :details, presence: { message: "can't be blank" }
end
