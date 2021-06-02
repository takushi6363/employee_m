class SessionsController < ApplicationController
  before_action :log_out

  def new
  end

  def create
    user = User.find_by(id: params[:user_id])
    if user
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      redirect_to user_homes_path(user.id)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
