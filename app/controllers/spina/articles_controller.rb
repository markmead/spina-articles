module Spina
  class ArticlesController < Spina::ApplicationController
    layout "default/application"

    def index
      @articles = Spina::Article.by_newest
    end

    def show
      @article = Spina::Article.find(params[:id])
    end
  end
end
