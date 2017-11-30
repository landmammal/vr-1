require 'faker'

User.create([{ first_name:'Administrator', last_name:'Man', username:'admin', race:'White', email:'admin@videorehearser.com', password:'admin123', password_confirmation:'admin123', age:Time.now, role: 0, approved: true, first_contact: false},
			 { first_name:'Instructor', last_name:'Sir', username:'instructor', race:'Asian', email:'instructor@videorehearser.com', password:'instructor123', password_confirmation:'instructor123', age:Time.now, role: 1, approved: true, first_contact: false},
			 { first_name:'Coach', last_name:'Jane', username:'coach', race:'White', email:'coach@videorehearser.com', password:'coach123', password_confirmation:'coach123', age:Time.now, role: 2, approved: true, first_contact: false},
			 { first_name:'Student', last_name:'John', username:'trainee', race:'Black', email:'trainee@videorehearser.com', password:'trainee123', password_confirmation:'trainee123', age:Time.now, role: 3, approved: true, first_contact: false}])

@user = User.all.first
@user.courses.build(title: "first course")
@user.save

@course = Course.all.first
@course.topics.build(title:"first topic", instructor_id:@user.id)
@course.save

@topic = Topic.all.first
@topic.lessons.build(title:"first lesson", instructor_id:@user.id)
@topic.save



# # courses topic and lessons
# 10.times do
#   course = Course.create(
#     title: Faker::Space.planet,
#     description: Faker::Lorem.sentence(4),
#     tags: Faker::Lorem.word,
#     privacy: 'public',
#     approval_status: "1",
#     instructor_id: 2
#   )
  
# # you can create more topics but then have to itirate over the topics while making lesson same for lessons and exp,prompt,model.
#   topic = course.topics.create(
#     title: Faker::Educator.course,
#     description: Faker::Lorem.sentence(4),
#     tags: Faker::Lorem.word,
#     privacy: 'public',
#     approval_status: "1",
#     course_id: course,
#     instructor_id:2
#   )

#   lesson = topic.lessons.create(
#     title: Faker::Space.planet,
#     description: Faker::Lorem.sentence(4),
#     tags: Faker::Lorem.word,
#     privacy: 'public',
#     approval_status: "1",
#     topic_id: topic,
#     instructor_id:2
#   )

#   lesson.explanations.create(
#     title: Faker::Space.planet,
#     token: "26695d8c37e99ecfce9a4e3290883e04",
#     video_token: "4f8bca227273050849582c9ab3e710d4",
#     script: Faker::Lorem.sentence(5),
#     position_prior: 1,
#     privacy: 'public',
#     lesson_id: lesson,
#     user_id:2
#   )

#   lesson.prompts.create(
#     title: Faker::Space.planet,
#     token: "26695d8c37e99ecfce9a4e3290883e04",
#     video_token: "4f8bca227273050849582c9ab3e710d4",
#     script: Faker::Lorem.sentence(5),
#     position_prior: 1,
#     privacy: 'public',
#     lesson_id: lesson,
#     user_id:2
#   )

#   lesson.models.create(
#     title: Faker::Space.planet,
#     token: "26695d8c37e99ecfce9a4e3290883e04",
#     video_token: "4f8bca227273050849582c9ab3e710d4",
#     script: Faker::Lorem.sentence(5),
#     position_prior: 1,
#     privacy: 'public',
#     lesson_id: lesson,
#     user_id:2
#   )
# end

# # groups
# 3.times do
#   Group.create(
#       name: Faker::GameOfThrones.house,
#       description: Faker::Lorem.paragraph(5),
#       instructor_id:2
#   )

# end
# Rehearsal.create(trainee_id: 4, course_id: 5, topic_id: 5, lesson_id: 5, group_id: nil, video_type: 'ziggeo', token: '', video_token: '61a2afb4365a410b6c5f6ffc81e60f5d', script: 'This is script 1', submission: true)
# Rehearsal.create(trainee_id: 4, course_id: 10, topic_id: 10, lesson_id: 10, group_id: nil, video_type: 'ziggeo', token: '', video_token: '61a2afb4365a410b6c5f6ffc81e60f5d', script: 'This is script 2', submission: true)
# Rehearsal.create(trainee_id: 4, course_id: 2, topic_id: 2, lesson_id: 2, group_id: nil, video_type: 'ziggeo', token: '', video_token: '61a2afb4365a410b6c5f6ffc81e60f5d', script: 'This is script 3', submission: true)
# LessonRehearsal.create(rehearsal_id: 1, lesson_id: 5)
# LessonRehearsal.create(rehearsal_id: 2, lesson_id: 10)
# LessonRehearsal.create(rehearsal_id: 3, lesson_id: 2)

# Feedback.create(user_id: 3, rehearsal_id: 1, rehearsal_rating: 3, concept_review: '' , notes: 'U look funny' , token: '' , video_token: '4d840f4dfbed6bfc96c23f933126be19' , approved: true , viewed_by_user: false , video_type: 'ziggeo')
# Feedback.create(user_id: 3, rehearsal_id: 2, rehearsal_rating: 1, concept_review: '' , notes: 'Do it again' , token: '' , video_token: '4d840f4dfbed6bfc96c23f933126be19' , approved: false , viewed_by_user: true , video_type: 'ziggeo')
# # Feedback.create(user_id: 3, rehearsal_id: 1, rehearsal_rating: 5, concept_review: '' , notes: 'Perfect' , token: '' , video_token: '4d840f4dfbed6bfc96c23f933126be19' , approved: true , viewed_by_user: false , video_type: 'ziggeo')
# PerformanceFeedback.create(rehearsal_id: 1, feedback_id: 1)
# PerformanceFeedback.create(rehearsal_id: 2, feedback_id: 2)
# # PerformanceFeedback.create(rehearsal_id: 3, feedback_id: 3)

# User.create(id=3, first_name="Coach", last_name="Jane", username="coach", role="coach", age=1480451392, race="White", gender=nil, email="coach@gmail.com", approved=true, terms_of_use=nil)


