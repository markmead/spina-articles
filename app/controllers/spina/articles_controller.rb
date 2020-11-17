module Spina
  class ArticlesController < Spina::ApplicationController
    def index
      @articles = Spina::Article.live
                                .published
                                .order(publish_date: :desc)
    end

    def show
      @article = Spina::Article.find(params[:id])
    end
  end
end
