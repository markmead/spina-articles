module Spina
  class ArticlesController < ApplicationController
    def index
      @articles = Spina::Article.live
                                .published
                                .order(publish_date: :desc)

      render layout: theme_layout
    end

    def show
      @article = Spina::Article.find(params[:id])

      render layout: theme_layout
    end

    private

    def theme_layout
      "#{current_theme.name.parameterize.underscore}/application"
    end
  end
end
