class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show] 
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5) #plural random name
  end
  
  def new #handled by 'create' method
    @article = Article.new
  end
  
  def edit #handled by 'update' method
    
  end
  
  def create
    @article = Article.new(article_params) #create an aritcle based on passed in params/ see private method
    @article.user = current_user
    if @article.save
      flash[:success] = "Article successfully created."
      redirect_to article_path(@article)
    else
      render :new #or 'new' - renders the 'new' template again
    end
  end
  
  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated!"
      redirect_to article_path(@article) #will go to 'show' the article updated
    else
      render :edit 
    end
  end
  
  
  def show
  end
  
  def destroy
    
    @article.destroy
    flash[:danger] = "Entry deleted"
    redirect_to articles_path
  end
  
  private
    def set_article
      @article = Article.find(params[:id])
    end
    
    def article_params
      params.require(:article).permit(:title, :description) #article is top level key, this permits the values (as in key-value pairings) of title and description
    end
    
    def require_same_user
      if current_user != @article.user and !current_user.admin?
      flash[:danger] = "You can only edit/delete your articles."
      redirect_to articles_path
      end
    end
  
  
end

