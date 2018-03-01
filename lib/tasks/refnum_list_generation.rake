desc "Ref Number Generation"
task :refnum_generation => :environment do
    items = [ [Course, 'Co'], [Topic, 'To'], [Lesson, 'Le'], [Explanation, 'Ex'], [Prompt, 'Pr'], [Model, 'Mo'], [Rehearsal, 'Re'], [Feedback, 'Fe'], [Concept, 'Con'] 
    ]
    
    items.each do |item|
        item[0].all.each do |i|
            i.refnum = item[1]+'_'+SecureRandom.hex(n=3) if i.refnum == nil
            i.save
        end
    end
    puts "DONE: Ref Number Generation"
end


desc "Auth Token Generation"
task :auth_token_generation => :environment do
    User.all.each do |user|
        user.auth_token = SecureRandom.hex(n=10) if user.auth_token == nil
        user.save
    end
    puts "DONE: Auth Token Generation"
end


desc "List of Topics and course"
task :topics_order => :environment do    
    Course.all.each do |course|
        if !course.topics_order || course.topics_order.size < 1
            course.topics_order = course.topics.map{ |t| t.refnum }
            course.save
        end
    end
    puts "DONE: List of Topics and course"
end


desc "List of Lessons in topic"
task :lessons_order => :environment do    
    Topic.all.each do |topic|
        if !topic.lessons_order || topic.lessons_order.size < 1
            topic.lessons_order = topic.lessons.map{ |l| l.refnum }
            topic.save
        end
    end
    puts "DONE: List of Lessons in topic"
end


desc "Set Privacy and Approval Status"
task :set_privacy => :environment do 
    items = [ Lesson, Topic ]  
    items.each do |item|
        item.all.each do |i|
            i.privacy ||= 1
            i.approval_status ||= 1
            i.save
        end
    end
    puts "DONE: Set Approval and Privacy"
end


desc "Set Courses Privacy"
task :courses_privacy => :environment do    
    Course.all.each do |course|
        course.privacy ||= 3
        course.approval_status ||= 1
        course.save
    end
    puts "DONE: Set Courses Privacy"
end


desc "Purge Unassociated Items"
task :purge => :environment do   

    Topic.all.each { |t| t.destroy if t.course == nil }
    Lesson.all.each { |l| l.destroy if l.topic == nil }

    puts "DONE: Purging Unassociated"
end



desc "Purge Course 1"
task :purge_course_1 => :environment do   

    User.all.each do |user|
        fis = CourseRegistration.where( user_id: user.id).where(course_id: 1 ).first

        CourseRegistration.where( user_id: user.id).where(course_id: 1 ).each do |cr|
            cr.destroy if cr != fis
        end
    end

    puts "DONE: Purging Course 1"
end


desc "Purge Course 201"
task :purge_course_201 => :environment do   

    User.all.each do |user|
        fis = CourseRegistration.where( user_id: user.id).where(course_id: 201 ).first

        CourseRegistration.where( user_id: user.id).where(course_id: 201 ).each do |cr|
            cr.destroy if cr != fis
        end
    end

    puts "DONE: Purging Course 201"
end