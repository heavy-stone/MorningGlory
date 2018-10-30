class LessonController < ApplicationController
  def step1
    render plain: "こんにちは、#{params[:name]}さん"
  end

  def step2
    render plain: params[:controller] + "#" + params[:action]
  end

  def step3
    redirect_to action: "step4"
  end

  def step4
    render plain: "step4です"
  end

  def step5
    # flash[:notice] = "step6に移動します"
    flash.notice = "step6に移動します"
    redirect_to action: "step6"
  end

  def step6
    render plain: flash[:notice]
  end

  def step7
    @price = (2000 * 1.08).floor
  end

  def step8
    @price = 10000
    render "step7"
  end

  def step9
    @price = "<script>alert('危険！')</script>こんにちは"
    render "step7"
  end

  def step14
    @message = "ごきげんいかが？\nRailsの勉強をがんばりましょう"
  end

  def step18
    @items = {"フライパン" => 2680, "ワイングラス" => 2550, "ペッパーミル" => 4515, "ピーラー" => 945 }
  end
end
