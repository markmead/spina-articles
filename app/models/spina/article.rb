module Spina
  class Article < ActiveRecord::Base
    extend FriendlyId
    friendly_id :title, use: [:slugged, :finders]

    belongs_to :image, class_name: "Spina::Image", optional: true

    validates :title, :body, :publish_date, presence: true
    validates :slug, uniqueness: true

    scope :by_newest, -> { order(publish_date: :DESC) }
    scope :is_live, -> { where("publish_date <= ? AND draft = ?", Date.today, 0) }

    def live?
      self.publish_date <= Date.today && !draft
    end

    def scheduled?
      self.publish_date >= Date.today && !draft
    end

    def draft?
      draft
    end

    def next_article
      self.class.live.where("id > ?", id).order("id ASC").first
    end

    def prev_article
      self.class.live.where("id < ?", id).order("id DESC").first
    end
  end
end
