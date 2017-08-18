json.array!(@exhibi) do |event2|
  json.extract! event2, :title
  json.start even2t.end_time
  json.url url_for(:controller => 'exhibition', :action => 'show_detail', :id => event2.id)
  json.allDay true
end
