class PaidVacationsController < ApplicationController
  before_action :set_up, only: [:index, :search]

  def index
    @user = User.find(params[:user_id])
    @vacations_all = Vacation.where(user_id: params[:user_id]).order(paid_vacation_day: :desc)
    @time_year = Time.new.year
  end

  def create
    @user = User.find(params[:user_id])
    @vacations = @user.vacations.new(vacation_params)
    @vacations.save
    redirect_to user_paid_vacations_path(@user.id)
  end

  def destroy
    vacation = Vacation.find(params[:id])
    vacation.destroy
    redirect_to user_paid_vacations_path(vacation.user_id)
  end

  def search
    @user = User.find(params[:user_id])
    @time_year = Time.new.year
    if params[:year] == ''
      @vacations_all = Vacation.where(user_id: params[:user_id]).order(paid_vacation_day: :desc)
    else
      @year = params[:year].to_i
      Vacation.enrollment_period_search(@year)
      time_a = Time.zone.parse("#{@year}-04-01")
      time_b = Time.zone.parse("#{@year + 1}-03-31")
      @vacations_all = Vacation.where(user_id: params[:user_id]).where(paid_vacation_day: time_a..time_b).order(paid_vacation_day: :desc)
    end
    render template: 'paid_vacations/index'
  end

  private

  def set_up
    @user = User.find(params[:user_id])
    Vacation.user_id_new(@user.id)
    Vacation.joiningday(@user.joining_day)
    Vacation.working_days_id_new(@user.working_days_id)
  end

  def vacation_params
    params.permit(:day, :paid_vacation_day).merge(user_id: @user.id)
  end
end
