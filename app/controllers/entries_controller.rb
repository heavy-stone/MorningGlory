class EntriesController < ApplicationController
  before_action :login_required, except: [:index, :show]

  def index
    if params[:member_id]
      @member = Member.find(params[:member_id])
      @entries = @member.entries
    else
      @entries = Entry.all
    end

    @entries = @entries.readable_for(current_member).order(posted_at: :desc).page(params[:page]).per(3)
  end

  def show
    @entry = Entry.readable_for(current_member).find(params[:id])
  end

  def new
    @entry = Entry.new(posted_at: Time.current)
  end

  def edit
    # 1対多の関連付け機能からの記事取り出し
    @entry = current_member.entries.find(params[:id])
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.author = current_member
    if @entry.save
      redirect_to @entry, notice: "記事を作成しました"
    else
      render "new"
    end
  end

  def update
    @entry = current_member.entries.find(params[:id])
    @entry.assign_attributes(entry_params)
    if @entry.save
      redirect_to @entry, notice: "記事を更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @entry = current_member.entries.find(params[:id])
    @entry.destroy
    redirect_to :entries, notice: "#{@entry.title}を削除しました"
  end

  private def entry_params
    params.require(:entry).permit(
      :member_id,
      :title,
      :body,
      :posted_at,
      :status
    )
  end

  def like
    @entry = Entry.published.find(params[:id])
    current_member.voted_entries << @entry
    if params[:show]
      redirect_to @entry, notice: "投票しました"
    else
      redirect_back(fallback_location: :entries)
      flash[:notice] = "投票しました"
    end
  end

  def unlike
    current_member.voted_entries.destroy(Entry.find(params[:id]))
    redirect_to :voted_entries, notice: "削除しました"
  end

  def voted
    @entries = current_member.voted_entries.published.order("votes.created_at DESC").page(params[:page]).per(15)
  end
end
