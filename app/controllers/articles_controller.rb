class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    @articles = Article.all #plural random name
  end
  
  def new #handled by 'create' method
    @article = Article.new
  end
  
  def edit #handled by 'update' method
    
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
  
  def update
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated!"
      redirect_to article_path(@article) #will go to 'show' the article updated
    else
      render :edit 
    end
  end
  
  
  def show
  end
  
  def destroy
    
    @article.destroy
    flash[:notice] = "Entry deleted"
    redirect_to articles_path
  end
  
  private
    def set_article
      @article = Article.find(params[:id])
    end
    
    def article_params
      params.require(:article).permit(:title, :description) #article is top level key, this permits the values (as in key-value pairings) of title and description
    end
  
  
end

