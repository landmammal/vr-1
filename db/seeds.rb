# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create([{ first_name:'Administrator', last_name:'Man', username:'admin', race:'White', email:'admin@gmail.com', password:'admin123', password_confirmation:'admin123', age:Time.now, role: 0},
			 { first_name:'Instructor', last_name:'Sir', username:'instructor', race:'Asian', email:'instructor@gmail.com', password:'instructor123', password_confirmation:'instructor123', age:Time.now, role: 1},
			 { first_name:'Coach', last_name:'Jane', username:'coach', race:'White', email:'coach@gmail.com', password:'coach123', password_confirmation:'coach123', age:Time.now, role: 2},
			 { first_name:'Student', last_name:'John', username:'trainee', race:'Black', email:'trainee@gmail.com', password:'trainee123', password_confirmation:'trainee123', age:Time.now, role: 3}])

Course.create([{title:'Customer Service 101', description:'This Course will help you get better at customer service', tags:'customer, service, customer service, help, helpdesk', status:1, instructor_id:2, privacy:'public'}])

CourseTopic.create([{ course_id:1, topic_id:1},
					{ course_id:1, topic_id:2}])

Topic.create([{title:'Customer Interaction', description:'This Topic will discuss how to interact with customers', tags:'customer, service, customer service, greeting, Front Desk', course_id:1, status:1, instructor_id:2, privacy:'public'}])
Topic.create([{title:'Problem Troubleshooting', description:'This Topic will cover how to troubleshoot problems', tags:'customer, service, customer service, greeting, Front Desk', course_id:1, status:1, instructor_id:2, privacy:'public'}])

TopicLesson.create([{topic_id:1, lesson_id:1},
					{topic_id:1, lesson_id:2},
					{topic_id:1, lesson_id:3},
					{topic_id:1, lesson_id:4}])

Lesson.create([{title:'Greeting Customer', description:'This lesson will cover how to greet Customers', tags:'customer, service, customer service, greeting, Front Desk', topic_id:1, status:1, instructor_id:2, privacy:'public'}])
Lesson.create([{title:'listening to customer issue', description:'This lesson will cover how to listen to the customer\'s prolem', tags:'customer, service, customer service, greeting, Front Desk', topic_id:1, status:1, instructor_id:2, privacy:'public'}])
Lesson.create([{title:'Routing customer to the right person', description:'This lesson will cover how to route the customer to the right directory', tags:'customer, service, customer service, greeting, Front Desk', topic_id:1, status:1, instructor_id:2, privacy:'public'}])
Lesson.create([{title:'Asking customer if they are satisfied', description:'This lesson will cover how to asses the customer\'s level of satsfaction', tags:'customer, service, customer service, greeting, Front Desk', topic_id:1, status:1, instructor_id:2, privacy:'public'}])

LessonExplanation.create([{ lesson_id:1, explanation_id:1}])
LessonPrompt.create([{ lesson_id:1, prompt_id:1}])
LessonModel.create([{ lesson_id:1, model_id:1}])

Explanation.create([{title:'helpdesk 101', token:'', video_token:'afd77bf07cc4dd2eb1fe312909f9e6fb', lesson_id:1, user_id:2, language:'en', privacy:'public', position_prior:'1' }])
Prompt.create([{title:'helpdesk 101 prompt', token:'', video_token:'f68856aab27a0cb615710153fdbbb707', lesson_id:1, user_id:2, language:'en', privacy:'public', position_prior:'1' }])
Model.create([{title:'helpdesk 101 model', token:'', video_token:'3ef318ac94a2a38d0fcf58b115a9d129', lesson_id:1, user_id:2, language:'en', privacy:'public', position_prior:'1' }])