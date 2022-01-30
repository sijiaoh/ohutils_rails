module PeerReviews
  class Result
    SCORE_KEYS = %i[fun technical creativity composition growth].freeze

    attr_accessor(*SCORE_KEYS)

    def initialize(user, peer_review)
      @reviews = user.received_peer_reviews_reviews.where(peer_review:)

      SCORE_KEYS.each { |key| send "#{key}=", 0 }

      calc_average_scores
    end

    def comments
      @comments ||= @reviews.map(&:comment)
    end

    private

    def calc_average_scores
      return if @reviews.blank?

      @reviews.each do |review|
        SCORE_KEYS.each do |key|
          send("#{key}=", send(key) + review[key])
        end
      end

      SCORE_KEYS.each do |key|
        send("#{key}=", send(key).to_f / @reviews.length)
      end
    end
  end
end
