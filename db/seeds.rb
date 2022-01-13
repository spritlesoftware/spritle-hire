# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create({ name: "Admin", email: "admin@example.com", mobile: "8524321285", password: "admin123", user_type: "admin" })
User.create({ name: "Candidate", email: "candidate@example.com", mobile: "8524321285", password: "candidate123", user_type: "candidate" })

tags = [{
  question_tag: "numerical_reasoning",
  count: 2
}, {
  question_tag: "attention_to_details",
  count: 2
}, {
  question_tag: "critical_thinking",
  count: 2
}, {
  question_tag: "verbal_reasoning",
  count: 4
}]

Test.create({
  name: "Evaluation Test",
  total_time: 1,
  tags: tags.to_json,
  status: "active"
})
