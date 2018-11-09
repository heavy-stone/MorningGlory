class ArticlesController < ApplicationController
  before_action :login_required, except: [:index, :show]

  # 記事一覧
  def index
    @articles = Article.order(released_at: :desc)
    @articles = @articles.open_to_the_public unless current_member

    unless current_member&.administrator?
      @articles = @articles.visible
    end
  end

  # 記事詳細
  def show
    # 訪問者や一般メンバーが閲覧権限のないページにアクセスすると、
    # 例外ActiveRecord::RecordNotFoundが発生するようにする
    articles = Article.all
    articles = articles.open_to_the_public unless current_member

    unless current_member&.administrator?
      articles = articles.visible
    end

    @article = articles.find(params[:id])
  end

  # 新規登録フォーム
  def new
    @article = Article.new
  end

  # 編集フォーム
  def edit
    @article = Article.find(params[:id])
  end

  # 新規作成
  def create
    @article = Article.new(params[:article])
    if @article.save
      redirect_to @article, notice: "#{@article.title} ニュース記事を登録しました"
    else
      render "new"
    end
  end

  # 更新
  def update
    @article = Article.find(params[:id])
    @article.assign_attributes(params[:article])
    if @article.save
      redirect_to @article, notice: "#{@article.title} ニュース記事を更新しました"
    else
      render "edit"
    end
  end

  # 削除
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to :articles, notice: "#{@article.title} ニュース記事を削除しました"
  end

end
