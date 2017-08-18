json.array!(@exhibi) do |event|
  json.extract! event, :title
  json.start event.start_time
  json.url url_for(:controller => 'exhibition', :action => 'show_detail', :id => event.id)
  json.allDay true
end
json.array!(@exhibi) do |event2|
  json.extract! event2, :title
  json.start event2.end_time
  json.url url_for(:controller => 'exhibition', :action => 'show_detail', :id => event2.id)
  json.allDay true
end

