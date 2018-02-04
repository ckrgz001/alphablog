class ArticlesController < ApplicationController

  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params) #create an aritcle based on passed in params/ see private method
    @article.save #save it
    redirect_to articles_show(@article)
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :description) #article is top level key, this permits the values (as in key-value pairings) of title and description
    end
  
  
end

