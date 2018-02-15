# require 'faker'
if Rails.env.development? || Rails.env.test?
	User.delete_all
	User.create([{ first_name:'Administrator', last_name:'Man', username:'admin', race:'White', email:'admin@videorehearser.com', password:'test123', age:Time.now, role: 0, approved: true, first_contact: false},
				{ first_name:'Instructor', last_name:'Sir', username:'instructor', race:'Asian', email:'instructor@videorehearser.com', password:'test123', age:Time.now, role: 1, approved: true, first_contact: false},
				{ first_name:'Coach', last_name:'Jane', username:'coach', race:'White', email:'coach@videorehearser.com', password:'test123', age:Time.now, role: 2, approved: true, first_contact: false},
				{ first_name:'Student', last_name:'John', username:'trainee', race:'Black', email:'trainee@videorehearser.com', password:'test123', age:Time.now, role: 3, approved: true, first_contact: false}])

	@user = User.find(1)
	@user.courses.build(title: "first course")
	@user.save

	@course = Course.find(1)
	@course.topics.build(title:"first topic", course_id:@course.id, instructor_id:@user.id)
	@course.save

	@topic = Topic.find(1)
	@topic.lessons.build(title:"first lesson", topic_id:@topic.id, instructor_id:@user.id)
	@topic.save
end
