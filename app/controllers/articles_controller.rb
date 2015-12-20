class ArticlesController < ApplicationController
    def new
        @article = Article.new
    end

    def create
        #render plain: params[:article].inspect #like print_r in php
        @article = Article.new(article_params)
        if  @article.save
            flash[:notice] = "Article was successfully created"
            # we need to redirect after creating the article
            # we need to pass the article because the path requires it
            # POST   article GET    /articles/:id(.:format)      articles#show
            # :id means the id of the article that is passed
            redirect_to article_path(@article)
        else
            render 'new'
        end
    end

    def show
        @article = Article.find(params[:id])
    end
    # method to permit the params for create
    private
    def article_params
        params.require(:article).permit(:title, :description)
    end
end
