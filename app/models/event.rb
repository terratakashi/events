class Event < ActiveRecord::Base
  validates :occasion, presence: true
  validates :date, presence: true
  validates :invited_count, presence: true

  def title
    if cancelled?
      "Cancelled: #{occasion} - #{invited_count} Invited"
    else
      "#{occasion} - #{invited_count} Invited"
    end
  end
end
