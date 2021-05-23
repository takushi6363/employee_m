class PaidVacationsAllController < ApplicationController
  def index
    @users = User.all
  end
end
