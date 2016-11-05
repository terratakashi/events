json.array!(@events) do |event|
  json.extract! event, :id
  json.title event.title
  json.start event.date
  json.allDay true
  json.color "red" if event.cancelled?
end
