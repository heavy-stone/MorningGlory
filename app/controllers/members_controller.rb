class MembersController < ApplicationController
  before_action :login_required

  # 会員一覧
  def index
    @members = Member.order("number").page(params[:page]).per(15)
  end

  def show
    @member = Member.find(params[:id])
  end

  def search
    if params[:q].present? # 空白検索時のエラー回避用
      @members = Member.search(params[:q]).page(params[:page]).per(15)
    else
      @members = Member.order("number").page(params[:page]).per(15)
    end
    render "index"
  end
end
