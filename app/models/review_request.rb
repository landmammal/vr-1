class ReviewRequest < ApplicationRecord
    has_many :peer_reviews
    belongs_to :rehearsal
end
