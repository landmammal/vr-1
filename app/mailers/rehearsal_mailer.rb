class RehearsalMailer < ApplicationMailer

    def send_for_peer_review( rehearsal, request )
        @rehearsal = rehearsal
        @request = request

        mail(to: request.person_email, subject: rehearsal.trainee.full_name+" has sent you a peer review request.") do |format|
            @recepient = request.person_name
            mailer_formats(format)
        end
    end
    
    def peer_review_submitted( review )
        @review = review

        trainee = review.review_request.rehearsal.trainee
        mail( to:trainee.email , subject: "You've got a peer review from: "+review.review_request.person_name ) do |format|
            @recepient = trainee.full_name
            mailer_formats(format)
        end
    end


end