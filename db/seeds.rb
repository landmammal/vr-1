# require 'faker'
if Rails.env.development? || Rails.env.test?
  User.delete_all
  User.create([
    { first_name:'Administrator', last_name:'Man', username:'admin', race:'White', email:'admin@videorehearser.com', password:'test123', age:Time.now, role: 0, approved: true, first_contact: false},
    { first_name:'Instructor', last_name:'Sir', username:'instructor', race:'Asian', email:'instructor@videorehearser.com', password:'test123', age:Time.now, role: 1, approved: true, first_contact: false},
    { first_name:'Coach', last_name:'Jane', username:'coach', race:'White', email:'coach@videorehearser.com', password:'test123', age:Time.now, role: 2, approved: true, first_contact: false},
    { first_name:'Student', last_name:'John', username:'trainee', race:'Black', email:'trainee@videorehearser.com', password:'test123', age:Time.now, role: 3, approved: true, first_contact: false}
  ])

  @admin = User.find_by_username('admin')
  @admin.courses.build([
    {title: "Free course", description:'this is a description for first course', privacy:'0', cstatus:'1'},
    {title: "Access Code course", description:'this is a description for second course', privacy:'1', cstatus:'1'},
    {title: "Paid course", description:'this is a description for third course', privacy:'2', cstatus:'1'},
    {title: "Private course", description:'this is a description for fourth course', privacy:'3', cstatus:'1'}
  ])
  @admin.save

  @courses = @admin.courses
  @courses.each do |course|
    course.topics.build([
      { title:"first topic", description:'this is a description for first topic', course_id:course.id, instructor_id:course.instructor.id },
      { title:"second topic", description:'this is a description for second topic', course_id:course.id, instructor_id:course.instructor.id } 
    ])
    course.save  
  end

  Topic.all.each do |topic|
    topic.lessons.build([
      { title:"first lesson", description:'this is a description for first lesson', topic_id:topic.id, instructor_id:topic.course.instructor.id },
      { title:"second lesson", description:'this is a description for second lesson', topic_id:topic.id, instructor_id:topic.course.instructor.id },
      { title:"third lesson", description:'this is a description for third lesson', topic_id:topic.id, instructor_id:topic.course.instructor.id },
      { title:"fourth lesson", description:'this is a description for fourth lesson', topic_id:topic.id, instructor_id:topic.course.instructor.id },
      { title:"fifth lesson", description:'this is a description for fifth lesson', topic_id:topic.id, instructor_id:topic.course.instructor.id }
    ])
    topic.save
  end

  Lesson.all.each do |lesson|
    lesson.explanations.build( lesson_id:lesson.id, title:'Explanation Test Video', video_token:'9681962d39338bded5a63422709f1022', script:'Random generated script here for Explanation', position_prior:1 )
    lesson.prompts.build( lesson_id:lesson.id, title:'Prompt Test Video', video_token:'32540d64be31529cc50749592d69b929', script:'Random generated script here for Prompt', position_prior:1 )
    lesson.models.build( lesson_id:lesson.id, title:'Model Test Video', video_token:'3a9cd76230216091b8ed4ba5140ec60e', script:'Random generated script here for Model', position_prior:1 )

    lesson.rehearsals.build([
      { trainee_id: 4, course_id: lesson.topic.course.id, topic_id: lesson.topic.id, lesson_id: lesson.id, video_token: "0177546f07d256f750fc2f779473effe", script: "SCRIPT FOR LESSON "+lesson.title, submission: false },
      { trainee_id: 4, course_id: lesson.topic.course.id, topic_id: lesson.topic.id, lesson_id: lesson.id, video_token: "e0725dd5ff134bbd483f3a1ad964a7bc", script: "SCRIPT FOR LESSON "+lesson.title, submission: false },
      { trainee_id: 1, course_id: lesson.topic.course.id, topic_id: lesson.topic.id, lesson_id: lesson.id, video_token: "0177546f07d256f750fc2f779473effe", script: "SCRIPT FOR LESSON "+lesson.title, submission: false },
      { trainee_id: 1, course_id: lesson.topic.course.id, topic_id: lesson.topic.id, lesson_id: lesson.id, video_token: "e0725dd5ff134bbd483f3a1ad964a7bc", script: "SCRIPT FOR LESSON "+lesson.title, submission: false }
    ])
    lesson.save
  end

  
end
