class PeerReviewsController < ApplicationController
    before_action :authenticate_user!, except: [:create]
    before_action :set_review, except: [:create]
    before_action :set_request, except: [:create]

    def create
        @request = ReviewRequest.find( params[:peer_review][:request_id] )
        review = @request.peer_reviews.build( review_params )

        if @request.save
            RehearsalMailer.peer_review_submitted( review ).deliver_later
            @sent = true
            respond_to do |format|
                format.js { }
            end
        end
    end
    
    def show

    end

    def destroy
        @id = @review.id
        if @review.destroy
            respond_to do |format|
                format.js { }
            end
        end
    end

    private 

    def review_params
        params.require( :peer_review ).permit( :token, :video_token, :notes, :rating )        
    end

    def set_request
        @request = ReviewRequest.find_by_hash_key( params[:review_request_id] )
    end

    def set_review
        @review = PeerReview.find( params[:id] )

        @request = @review.review_request
        @rehearsal = @request.rehearsal
        @lesson = @rehearsal.lesson
        @topic = @lesson.topic
        @course = @topic.course
    end

end
