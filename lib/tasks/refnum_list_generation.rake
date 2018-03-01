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
    puts "DONE 1"
end


desc "List of Topics and course"
task :topics_order => :environment do    
    Course.all.each do |course|
        if !course.topics_order || course.topics_order.size < 1
            course.topics_order = course.topics.map{ |t| t.refnum }
            course.save
        end
    end
    puts "DONE 2"
end


desc "List of Lessons in topic"
task :lessons_order => :environment do    
    Topic.all.each do |topic|
        if !topic.lessons_order || topic.lessons_order.size < 1
            topic.lessons_order = topic.lessons.map{ |l| l.refnum }
            topic.save
        end
    end
    puts "DONE 3"
end


desc "Set Topics Privacy"
task :topics_privacy => :environment do    
    Topic.all.each do |topic|
        topic.privacy ||= 1
        topic.approval_status ||= 1
        topic.save
    end
    puts "DONE 4"
end


desc "Set Lessons Privacy"
task :lessons_privacy => :environment do    
    Lesson.all.each do |lesson|
        lesson.privacy ||= 1
        lesson.approval_status ||= 1
        lesson.save
    end
    puts "DONE 5"
end

desc "Purge Unassociated Items"
task :purge => :environment do   

    Topic.all.each { |t| t.destroy if t.course == nil }
    Lesson.all.each { |l| l.destroy if l.topic == nil }

    puts "DONE Purging Unassociated"
end