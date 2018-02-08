class ReviewRequestsController < ApplicationController
    before_action :authenticate_user!, except: [:show]
    before_action :set_external_request, only: [:show]
    before_action :set_request, except: [:create, :show]
    before_action :set_rehearsal, except: [:show]

    def create
        email = params[:review_request][:person_email]
        already_exists = ReviewRequest.all.map{ |x| x if (x.person_email == email && x.rehearsal == @rehearsal )}.compact

        if already_exists.size > 0
            request = already_exists[0]
        else    
            request = @rehearsal.review_requests.build(request_params)
            request.hash_key = SecureRandom.hex(n=5)
            until ReviewRequest.all.map{ |x| x if ( x.hash_key == request.hash_key ) }.compact.size == 0
                request.hash_key = SecureRandom.hex(n=5)
            end
            @rehearsal.save
        end

        RehearsalMailer.send_for_peer_review( @rehearsal, request ).deliver_later
        @sent = true

        respond_to do |format|
            format.js { render 'request.js.erb' }
        end
    end
    
    def show
        
    end

    def destroy
        @id = @request.id
        @request.destroy

        respond_to do |format|
            format.js { render 'request.js.erb' }
        end
    end


    private 

    def request_params
        params.require( :review_request ).permit( :person_name, :person_email, :rehearsal_id )        
    end

    def set_rehearsal
        @rehearsal = Rehearsal.find( params[:review_request][:rehearsal_id] )
    end

    def set_request
        @request = ReviewRequest.find(params[:id])
        others
    end

    def set_external_request
        @request = ReviewRequest.find_by_hash_key(params[:id])
        others
    end
    
    def others
        @rehearsal = @request.rehearsal
        @lesson = @rehearsal.lesson
        @prompt = @lesson.prompts.find_by(position_prior: '1')
        @topic = @lesson.topic
        @course = @topic.course
    end

end
