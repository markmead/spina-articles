module Spina
  module Admin
    class ArticlesController < AdminController
      before_action :set_breadcrumb
      before_action :set_article, only: %w[edit update destroy]
      before_action :set_tabs, only: %w[new create edit update]

      layout "spina/admin/admin"

      def index
        @articles = Article.by_newest
      end

      def new
        add_breadcrumb "New #{I18n.t("spina.articles.scaffold_name")}", spina.new_admin_article_path
        @article = Spina::Article.new
      end

      def create
        add_breadcrumb "New #{I18n.t("spina.articles.scaffold_name")}"
        @article = Spina::Article.new(article_params)

        if @article.save
          redirect_to spina.admin_article_url(@article)
        else
          render :new
        end
      end

      def edit
        add_breadcrumb @article.title
      end

      def update
        respond_to do |format|
          if @article.update(article_params)
            format.html { redirect_to spina.admin_articles_url, notice: I18n.t("spina.articles.saved") }
            format.js
          else
            render :edit
          end
        end
      end

      def destroy
        @article.destroy
        redirect_to spina.admin_articles_url
      end

      private

      def set_article
        @article = Spina::Article.find(params[:id])
      end

      def set_breadcrumb
        add_breadcrumb I18n.t("spina.articles.scaffold_name_plural"), spina.admin_articles_path
      end

      def set_tabs
        @tabs = %w[content search_engines advanced]
      end

      def article_params
        params.require(:article).permit(
          :author,
          :body,
          :draft,
          :image_id,
          :publish_date,
          :seo_description,
          :seo_title,
          :slug,
          :teaser,
          :title,
        )
      end
    end
  end
end
