module RehearsalsHelper
	
	def student_pic(user)
		user.profile_file_name.present? ? profile = user.profile.url(:square) : profile = '/assets/default_user.png'
		return profile
	end

	def time_diff(today, submitted_date)
	  seconds_diff = (today.to_i - submitted_date.to_i).abs

	  seconds = seconds_diff
	  minutes = seconds_diff / 60
	  hours = seconds_diff / 3600
	  days = seconds_diff / 86400
	  weeks = seconds_diff / 604800

	  if seconds < 59
	  	timediff = 'just now'
	  elsif minutes < 60
	  	timediff = minutes.to_s + ( minutes > 1 ? ' minutes ' : ' minute ' ) + 'ago'
	  elsif hours < 24
	  	timediff = hours.to_s + ( hours > 1 ? ' hours ' : ' hour ' ) + 'ago'
	  elsif days < 7
	  	timediff = days.to_s + ( days > 1 ? ' days ' : ' day ' ) + 'ago'
	  else
	  	timediff = weeks.to_s + ( weeks > 1 ? ' weeks ' : ' week ' ) + 'ago'
	  end

	  return timediff
	end

	def rehearsal_approved(id)
		rehearsal = Rehearsal.find(id)
		
		(rehearsal.submission == false || !rehearsal.submission) ? status = 'blankdot' : ((rehearsal.approval_status == 1 ) ? status = 'greendot' : ((rehearsal.approval_status == 2 ) ? status = 'reddot' : status = 'orangedot'))
		
		rehearsal.feedbacks.each do |feedback|
			if feedback.approved == true || rehearsal.approval_status == 1
				status = 'greendot'
				# break
			end
			if feedback.approved == true || rehearsal.approval_status == 2
				status = 'reddot'
				# break
			end
				
		end

		return status
	end

	def genReherasalRef(id)
		ranNum = ((id * 30) + 5 ) * 7
		return 'r'+ranNum.to_s+'id'+id.to_s
	end







	def new_rehearsal(rehearsal)
		if (rehearsal.feedbacks.size < 1 && rehearsal.approval_status == 0) || (rehearsal.feedbacks.size > 1 && rehearsal.approval_status == 1) && User.exists?(rehearsal.trainee_id) 
			return 'new_rehearsal'
		end
	end

	def rehearsals_count(course)
		count = 0
		course.rehearsals.where(submission: true).each do |rehearsal|
			if params[:list] == "all"
				count += 1
			else
				if (rehearsal.feedbacks.size < 1 && rehearsal.approval_status == 0) || (rehearsal.feedbacks.size > 1 && rehearsal.approval_status == 1) && User.exists?(rehearsal.trainee_id) 
					count += 1
				end
			end
		end
		return count.to_s
	end

	def method_name(course)
		if params[:list] == "all"
			return @courses
		else
			if (rehearsal.feedbacks.size < 1 && rehearsal.approval_status == 0) || (rehearsal.feedbacks.size > 1 && rehearsal.approval_status == 1) && User.exists?(rehearsal.trainee_id) 
				count += 1
			end
		end
	end

	# def rehearsals_c
	# 	courses = {};

	# 	current_user.courses.each do |course|
	# 		course.rehearsals.where(submission: true).each do |rehearsal|
	# 			courses[course] = {}
	# 			courses[course][rehearsal.topic] = {}

	# 			if (rehearsal.approval_status==1 || rehearsal.feedbacks.size>0)
	# 				courses[course][rehearsal.topic][rehearsal.lesson] = []
	# 				courses[course][rehearsal.topic][rehearsal.lesson] << rehearsal
	# 			end
	# 		end
	# 	end

	# 	return courses
	# end

end