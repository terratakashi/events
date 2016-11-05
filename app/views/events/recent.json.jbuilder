json.array!(@events) do |event|
  json.extract! event, :id
  json.title "#{event.occasion} - Invited Count : #{event.invited_count} "
  json.start event.date
  json.allDay true
end
