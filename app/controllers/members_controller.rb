class MembersController < ApplicationController
  # 会員一覧
  def index
    @members = Member.order("number")
  end

  def show
    @member = Member.find(params[:id])
  end

  # 新規作成フォーム
  def new
    @member = Member.new(birthday: Date.new(1980, 1, 1))
    # @member = Member.new
  end

  # 更新フォーム
  def edit
    @member = Member.find(params[:id])
  end

  def create

  end


  def update

  end

  def destroy

  end

  def search
    @members = Member.search(params[:q])
    render "index"
  end


end
