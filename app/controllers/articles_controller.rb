class ArticlesController < ApplicationController

  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params) #create an aritcle based on passed in params/ see private method
    
    if @article.save
      flash[:notice] = "Article successfully created."
      redirect_to article_path(@article)
    else
      render :new #or 'new' - renders the 'new' template again
    end
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :description) #article is top level key, this permits the values (as in key-value pairings) of title and description
    end
  
  
end

