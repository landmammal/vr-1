desc "Ref Number Generation"
task :refnum => :environment do
    items = [ [Course, 'Co'], [Topic, 'T'], [Lesson, 'L'], [Explanation, 'Comp'], [Prompt, 'Comp'], [Model, 'Comp'], [Rehearsal, 'Reh'], [Feedback, 'F'], [Concept, 'Co'] ]
    
    items.each do |item|
        item[0].each do |i|
            i.refnum == SecureRandom.hex(n=3) if i.refnum.blank?
            i.save
        end
    end
end


desc "List of Topics and Lessons"
task :refnum => :environment do
    items = [ Course, Topic ]
    
    items.each do |item|
        item[0].each do |i|
            i.refnum == SecureRandom.hex(n=3) if i.refnum.blank?
            i.save
        end
    end
end
