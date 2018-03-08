module FeedbacksHelper
	def feedbackSent
		numfeed = @rehearsal.feedbacks.where(user_id: current_user.id).size
		return numfeed > 0 ? "You've sent "+numfeed.to_s+" feedback for this rehearsal." : "No feedback for this rehearsal yet"
	end
end
