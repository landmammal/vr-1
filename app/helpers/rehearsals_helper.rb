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
	  	timediff = minutes.to_s + ( minutes > 1 ? ' minutes ' : ' minute ' )
	  elsif hours < 24
	  	timediff = hours.to_s + ( hours > 1 ? ' hours ' : ' hour ' )
	  elsif days < 7
	  	timediff = days.to_s + ( days > 1 ? ' days ' : ' day ' ) 	
	  else
	  	timediff = weeks.to_s + ( weeks > 1 ? ' weeks ' : ' week ' )  	
	  end

	  return timediff + 'ago'

	end

	def rehearsal_approved(id)
		rehearsal = Rehearsal.find(id)
		
		(rehearsal.submission == false || !rehearsal.submission) ? status = 'blankdot' : status = 'orangedot'
		
		rehearsal.feedbacks.each do |feedback|
			if feedback.approved == true
				status = 'greendot'
				break
			end
		end

		return status
	end

	def genReherasalRef(id)
		ranNum = ((id * 30) + 5 ) * 7
		return 'r'+ranNum.to_s+'id'+id.to_s
	end

end