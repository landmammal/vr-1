# require 'faker'

User.create([{ first_name:'Administrator', last_name:'Man', username:'admin', race:'White', email:'admin@gmail.com', password:'admin123', password_confirmation:'admin123', age:Time.now, role: 0},
			 { first_name:'Instructor', last_name:'Sir', username:'instructor', race:'Asian', email:'instructor@gmail.com', password:'instructor123', password_confirmation:'instructor123', age:Time.now, role: 1},
			 { first_name:'Coach', last_name:'Jane', username:'coach', race:'White', email:'coach@gmail.com', password:'coach123', password_confirmation:'coach123', age:Time.now, role: 2},
			 { first_name:'Student', last_name:'John', username:'trainee', race:'Black', email:'trainee@gmail.com', password:'trainee123', password_confirmation:'trainee123', age:Time.now, role: 3}])



200.times do
  course = Course.create(
    title: Faker::Space.planet,
    description: Faker::Lorem.sentence(4),
    tags: Faker::Lorem.word,
    privacy: 'public',
    approval_status: "1",
    instructor_id: 2
  )

# you can create more topics but then have to itirate over the topics while making lesson same for lessons and exp,prompt,model.
  topic = course.topics.create(
    title: Faker::Space.planet,
    description: Faker::Lorem.sentence(4),
    tags: Faker::Lorem.word,
    privacy: 'public',
    approval_status: "1",
    course_id: course,
    instructor_id:2
  )

  lesson = topic.lessons.create(
    title: Faker::Space.planet,
    description: Faker::Lorem.sentence(4),
    tags: Faker::Lorem.word,
    privacy: 'public',
    approval_status: "1",
    topic_id: topic,
    instructor_id:2
  )

  lesson.explanations.create(
    title: Faker::Space.planet,
    token: "26695d8c37e99ecfce9a4e3290883e04",
    video_token: "4f8bca227273050849582c9ab3e710d4",
    script: Faker::Lorem.sentence(5),
    position_prior: 1,
    privacy: 'public',
    lesson_id: lesson,
    user_id:2
  )

  lesson.prompts.create(
    title: Faker::Space.planet,
    token: "26695d8c37e99ecfce9a4e3290883e04",
    video_token: "4f8bca227273050849582c9ab3e710d4",
    script: Faker::Lorem.sentence(5),
    position_prior: 1,
    privacy: 'public',
    lesson_id: lesson,
    user_id:2
  )

  lesson.models.create(
    title: Faker::Space.planet,
    token: "26695d8c37e99ecfce9a4e3290883e04",
    video_token: "4f8bca227273050849582c9ab3e710d4",
    script: Faker::Lorem.sentence(5),
    position_prior: 1,
    privacy: 'public',
    lesson_id: lesson,
    user_id:2
  )
end
