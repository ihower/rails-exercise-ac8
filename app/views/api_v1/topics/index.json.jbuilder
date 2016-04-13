json.meta do
  json.current_page @topics.current_page
  json.total_pages @topics.total_pages
  json.per_page @topics.limit_value
  json.next_url (@topics.last_page?)? nil : v1_topics_url( :page => @topics.next_page )
  json.previous_url (@topics.first_page?)? nil : v1_topics_url( :page => @topics.prev_page )
end

json.results do
  json.array!(@topics) do |topic|
    json.partial! 'topic', topic: topic
  end
end
