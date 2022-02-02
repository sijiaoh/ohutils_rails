module PeerReviews
  class Result
    attr_accessor(*PeerReviews::Review::SCORE_KEYS)

    def initialize(user, peer_review)
      @reviews = user.received_peer_reviews_reviews.where(peer_review:)

      PeerReviews::Review::SCORE_KEYS.each { |key| send "#{key}=", 0 }

      calc_average_scores
    end

    def comments
      @comments ||= @reviews.map(&:comment)
    end

    private

    def calc_average_scores
      return if @reviews.blank?

      @reviews.each do |review|
        PeerReviews::Review::SCORE_KEYS.each do |key|
          send("#{key}=", send(key) + review[key])
        end
      end

      PeerReviews::Review::SCORE_KEYS.each do |key|
        send("#{key}=", send(key).to_f / @reviews.length)
      end
    end
  end
end
