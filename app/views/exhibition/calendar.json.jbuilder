json.array!(@exhibi) do |event|
  json.extract! event, :title
  json.start event.start_time
  json.end event.end_time
  json.url event_url(event, format: :html)
end


