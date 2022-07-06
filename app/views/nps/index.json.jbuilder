# frozen_string_literal: true

json.array! @nps do |n|
  json.call(n, :id, :score, :touchpoint)

  json.respondent_class n.respondent_class
  json.respondent_id n.respondent_id
  json.respondent n.respondent.name

  json.object_class n.object_class
  json.object_id n.object_id
  json.object n.object.name

  json.created_at n.created_at
  json.updated_at n.updated_at
end
