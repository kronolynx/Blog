class ArticlesController < ApplicationController

  before_action :set_article, only: [:edit, :update, :show, :destroy]


    def index
        @articles = Article.all # we just get all the articles and saved them
    end
    def new
        @article = Article.new
    end

    def edit
        # @article = Article.find(params[:id])
    end

    def create
        #render plain: params[:article].inspect #like print_r in php
        @article = Article.new(article_params)
        if  @article.save
            flash[:success] = "Article was successfully created"
            # we need to redirect after creating the article
            # we need to pass the article because the path requires it
            # POST   article GET    /articles/:id(.:format)      articles#show
            # :id means the id of the article that is passed
            redirect_to article_path(@article)
        else
            render 'new'
        end
    end

    def update
      # @article = Article.find(params[:id])
      if @article.update(article_params)
        flash[:success] = "Article was successfully updated"
        redirect_to article_path(@article)
      else
        render 'edit'
      end
    end

    def show
        @article = Article.find(params[:id])
    end

    def destroy
      #@article = Article.find(params[:id])
      @article.destroy
      flash[:danger] = "Article was successfully deleted"
      redirect_to articles_path
    end
    # method to permit the params for create
    private
    #method to replace redundant variable
    def set_article
      @article = Article.find(params[:id])
    end
    def article_params
        params.require(:article).permit(:title, :description)
    end
end
