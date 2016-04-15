json.id topic.id
json.subject topic.subject
json.content topic.content

json.user do
  json.id topic.user_id
  json.name topic.user.try(:display_name)
end

json.image_original_url asset_url(topic.image.url)
json.image_medium_url asset_url(topic.image.url(:medium))
json.image_thumb_url asset_url(topic.image.url(:thumb))

json.image_file_name topic.image_file_name
json.image_content_type topic.image_content_type
json.image_file_size topic.image_file_size
json.image_updated_at topic.image_updated_at

json.created_at topic.created_at
json.updated_at topic.updated_at
