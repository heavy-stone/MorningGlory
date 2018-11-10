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
  end

  def edit
  end
end
