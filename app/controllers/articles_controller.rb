class ArticlesController < ApplicationController
  
  before_action :set_article, only:[:edit,:update, :show, :destroy]
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @article = Article.new
  end
  
  def edit
    
  end
  
  def update
    if @article.update(article_params)
      flash[:success]= "The article was updated successfully."
      redirect_to article_path(@article)
    else
      #flash[:notice]= "there was a problem."
      render 'edit'
    end
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:success]= "The article was saved successfully."
      redirect_to article_path(@article)
    else
      #flash[:notice]= "there was a problem."
      render 'new'
    end
  end
  
  def show
  end
  
  def destroy
    @article.destroy
    flash[:danger]= "The article was destroyed successfully."
    redirect_to articles_path
  end
  
  private
  
  def set_article
    @article = Article.find(params[:id])
  end
  
  def article_params
    params.require(:article).permit(:title, :description)
  end
  
end