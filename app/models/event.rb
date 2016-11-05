class Event < ActiveRecord::Base
  def title
    if cancelled?
      "Cancelled: #{occasion} - #{invited_count} Invited"
    else
      "#{occasion} - #{invited_count} Invited"
    end
  end
end
