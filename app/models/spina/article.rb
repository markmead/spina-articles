module Spina
  class Article < ActiveRecord::Base
    extend FriendlyId
    friendly_id :title, use: [:slugged, :finders]

    belongs_to :image, class_name: "Spina::Image", optional: true

    validates :title, :body, :publish_date, presence: true
    validates :slug, uniqueness: true

    scope :published, -> { where('publish_date <= ?', Date.today) }
    scope :live, -> { where(draft: false) }

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
      self.class.live.where("id > ?", id).order(publish_date: :asc).first
    end

    def prev_article
      self.class.live.where("id < ?", id).order(publish_date: :desc).first
    end
  end
end
