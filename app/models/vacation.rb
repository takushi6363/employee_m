class Vacation < ApplicationRecord
  belongs_to :user
  

  def self.user_id_new(user_id)
    @user_id =  user_id
  end

  def self.joiningday(joining_day)
    @joining_day_month = joining_day.month
  end

  def self.working_days_id_new(working_days_id)
    @working_days_id = working_days_id
  end

  def self.business_year #年度表示に使用
    require "time"
    time_now = Time.new
    month = time_now.month
    if month.between?(4, 12)
    time_now.year
    else
    time_now.year - 1
    end
  end

  def self.vacation_same_one #年度内の有給消化を表示
    require "time"
    time_now = Time.new
    month_now = time_now.month
    if month_now.between?(4, 12)
    time_a =Time.zone.parse("#{time_now.year}-04-01")
    @vacations =Vacation.where(user_id: @user_id).where(paid_vacation_day: time_a..time_now).order(paid_vacation_day: :desc)
    else
    time_b = Time.zone.parse("#{time_now.year - 1}-04-01")
    @vacations = Vacation.where(user_id: @user_id).where(paid_vacation_day: time_b..time_now).order(paid_vacation_day: :desc)
    end
  end
  
  def self.vacation_same_one_last_year #昨年度の有休消化を表示
    require "time"
    time_now = Time.new
    month_now = time_now.month
    if month_now.between?(4, 12)
    time_last_year_a =Time.zone.parse("#{time_now.year - 1}-04-01")
    time_now_year =Time.zone.parse("#{time_now.year}-3-31")
    @vacations_last_year =Vacation.where(user_id: @user_id).where(paid_vacation_day: time_last_year_a..time_now_year).order(paid_vacation_day: :desc)
    else
    time_last_year_b= Time.zone.parse("#{time_now.year - 2}-04-01")
    time_now_year =Time.zone.parse("#{time_now.year - 1}-03-31")
    @vacations_last_year = Vacation.where(user_id: @user_id).where(paid_vacation_day: time_last_year_b..time_now_year).order(paid_vacation_day: :desc)
    end
  end
  
  def self.enrollment_period  #在籍日数
    user = User.find_by(id: @user_id)
    date_today = Date.today
    joining_day = user.joining_day
    if date_today.month - joining_day.month >= 0
      year = date_today.year - joining_day.year
      month = date_today.month - joining_day.month
    else
      year = date_today.year -  joining_day.year - 1
      month = date_today.month - joining_day.month + 12
    end
     sum_month = (year * 12) + month
  end
  
  
  def self.paid_grant  #今年の有給休暇計算
    @sum_month = Vacation.enrollment_period
    joining_day_month = @joining_day_month
    if joining_day_month.between?(4, 9) #4月〜9月
      difference = joining_day_month - 4
      if @sum_month < 6
        return 0
      elsif @sum_month.between?(6, (11 - difference)) #半年
        return 10
      elsif (@sum_month + difference).between?(12, 23) #1年 
        return 11
      elsif (@sum_month + difference).between?(24, 35) #2年 
        return 12
      elsif (@sum_month + difference).between?(36, 47) #3年 
        return 14
      elsif (@sum_month + difference).between?(48, 59) #4年 
        return 16
      elsif (@sum_month + difference).between?(60, 71) #5年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 10  #10月
      difference = 6
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 10
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 11
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 12
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 14
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 16
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 11  #11月
      difference = 5
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 10
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 11
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 12
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 14
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 16
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 12  #12月
      difference = 4
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 10
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 11
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 12
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 14
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 16
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 1  #1月
      difference = 3
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 10
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 11
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 12
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 14
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 16
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 18
      else
        return 20
      end
      
    elsif joining_day_month == 2  #2月
      difference = 2
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 10
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 11
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 12
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 14
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 16
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 3  #3月
      difference = 1
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 10
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 11
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 12
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 14
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 16
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 18
      else
        return 20
      end
      
  
    end
  
  end
  
  
  def self.paid_grant_last_year #昨年の有給休暇計算
    @sum_month = Vacation.enrollment_period
    joining_day_month = @joining_day_month
    if joining_day_month.between?(4, 9) #4月〜9月
      difference = joining_day_month - 4
      if @sum_month < 6
        return 0
      elsif @sum_month.between?(6, (11 - difference)) #半年
        return 0
      elsif (@sum_month + difference).between?(12, 23) #1年 
        return 10
      elsif (@sum_month + difference).between?(24, 35) #2年 
        return 11
      elsif (@sum_month + difference).between?(36, 47) #3年 
        return 12
      elsif (@sum_month + difference).between?(48, 59) #4年 
        return 14
      elsif (@sum_month + difference).between?(60, 71) #5年 
        return 16
      elsif (@sum_month + difference).between?(72, 83) #6年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 10  #10月
      difference = 6
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 0
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 10
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 11
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 12
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 14
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 16
      elsif (@sum_month - difference).between?(72, 83) #6年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 11  #11月
      difference = 5
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 0
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 10
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 11
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 12
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 14
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 16
      elsif (@sum_month - difference).between?(72, 83) #6年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 12  #12月
      difference = 4
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 0
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 10
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 11
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 12
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 14
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 16
      elsif (@sum_month - difference).between?(72, 83) #6年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 1  #1月
      difference = 3
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 0
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 10
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 11
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 12
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 14
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 16
      elsif (@sum_month - difference).between?(72, 83) #6年 
        return 18
      else
        return 20
      end
      
    elsif joining_day_month == 2  #2月
      difference = 2
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 0
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 10
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 11
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 12
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 14
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 16
      elsif (@sum_month - difference).between?(72, 83) #6年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 3  #3月
      difference = 1
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 0
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 10
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 11
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 12
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 14
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 16
      elsif (@sum_month - difference).between?(72, 83) #6年 
        return 18
      else
        return 20
      end
    end
  end
  
  def self.total_paid_holidays #今年度の有給休暇の合計
    num = 0
    Vacation.vacation_same_one.each do |vacation|
     num += vacation.day
    end
    return num
  end
  
  def self.total_paid_holidays_last_year #昨年度の有給休暇の合計
    num = 0
    Vacation.vacation_same_one_last_year.each do |vacation|
     num += vacation.day
    end
    return num
  end
  
  def self.paid_grant_working_day
    if @working_days_id == 2
      return Vacation.paid_grant 
    elsif @working_days_id == 3
       paid_grant_day = Vacation.paid_grant * 0.75
       return paid_grant_day.floor
    elsif @working_days_id == 4
       paid_grant_day = Vacation.paid_grant * 0.58
       return paid_grant_day.floor
    elsif @working_days_id == 5
       paid_grant_day = Vacation.paid_grant * 0.38
       return paid_grant_day.floor
    else @working_days_id == 6
       paid_grant_day = Vacation.paid_grant * 0.19
       return paid_grant_day.floor
    end
  end
  
  def self.paid_grant_last_year_working_day
    if @working_days_id == 2
       return Vacation.paid_grant_last_year
    elsif @working_days_id == 3
       paid_grant_day = Vacation.paid_grant_last_year * 0.75
       return  paid_grant_day.floor
    elsif @working_days_id == 4
       paid_grant_day = Vacation.paid_grant_last_year * 0.58
       return paid_grant_day.floor
    elsif @working_days_id == 5
       paid_grant_day = Vacation.paid_grant_last_year * 0.38
       return paid_grant_day.floor
    else @working_days_id == 6
        paid_grant_day = Vacation.paid_grant_last_year * 0.19
       return paid_grant_day.floor
    end
  end
  
  def self.paid_grant_day #今年度有休消化日数
      Vacation.paid_grant_working_day - Vacation.total_paid_holidays
  end
  
  def self.paid_grant_day_last_year #昨年度有休消化日数
     paid_g_d_l_y = Vacation.paid_grant_last_year_working_day - Vacation.total_paid_holidays_last_year
     if paid_g_d_l_y <= 0
        return 0
     else
        return paid_g_d_l_y
     end
  end
  

  #検索時の有休消化表示
  
  def self.enrollment_period_search(year) #在籍日数
      user = User.find_by(id: @user_id)
      @year = year
      date_today = Date.today
      joining_day = user.joining_day
      date_today =Time.zone.parse("#{@year}-04-01")
      joining_day_year  = @joining_day_year.to_i
      if date_today.month - joining_day.month >= 0
        year = date_today.year - joining_day.year
        month = date_today.month - joining_day.month
      else
        year = date_today.year -  joining_day.year - 1
        month = date_today.month - joining_day.month + 12
      end
       sum_month = (year * 12) + month
  end
  
  def self.paid_grant_search #今年の有給休暇計算
    @sum_month = Vacation.enrollment_period_search(@year)
    joining_day_month = @joining_day_month
    if joining_day_month.between?(4, 9) #4月〜9月
      difference = joining_day_month - 4
      if @sum_month < 6
        return 0
      elsif @sum_month.between?(6, (11 - difference)) #半年
        return 10
      elsif (@sum_month + difference).between?(12, 23) #1年 
        return 11
      elsif (@sum_month + difference).between?(24, 35) #2年 
        return 12
      elsif (@sum_month + difference).between?(36, 47) #3年 
        return 14
      elsif (@sum_month + difference).between?(48, 59) #4年 
        return 16
      elsif (@sum_month + difference).between?(60, 71) #5年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 10  #10月
      difference = 6
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 10
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 11
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 12
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 14
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 16
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 11  #11月
      difference = 5
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 10
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 11
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 12
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 14
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 16
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 12  #12月
      difference = 4
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 10
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 11
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 12
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 14
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 16
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 1  #1月
      difference = 3
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 10
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 11
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 12
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 14
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 16
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 18
      else
        return 20
      end
      
    elsif joining_day_month == 2  #2月
      difference = 2
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 10
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 11
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 12
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 14
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 16
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 3  #3月
      difference = 1
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 10
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 11
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 12
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 14
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 16
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 18
      else
        return 20
      end
      
  
    end
  
  end
  
  def self.paid_grant_working_day_search
    if @working_days_id == 2
      return Vacation.paid_grant_search
    elsif @working_days_id == 3
       paid_grant_day_search = Vacation.paid_grant_search * 0.75
       return paid_grant_day_search.floor
    elsif @working_days_id == 4
       paid_grant_day_search = Vacation.paid_grant_search * 0.58
       return paid_grant_day_search.floor
    elsif @working_days_id == 5
       paid_grant_day_search = Vacation.paid_grant_search * 0.38
       return paid_grant_day_search.floor
    else @working_days_id == 6
        paid_grant_day_search = Vacation.paid_grant_search * 0.19
       return paid_grant_day_search.floor
    end
  end

# 社員一覧の有給休暇

  def self.total_paid_holidays_all(user_id) #今年度の有給休暇の合計
   @user_all = User.find_by(id: user_id)
   num = 0
   Vacation.vacation_same_one_all.each do |vacation|
   num += vacation.day
   end
   return num
  end

  def self.vacation_same_one_all #年度内の有給消化を表示
   require "time"
   time_now = Time.new
   month_now = time_now.month
   if month_now.between?(4, 12)
   time_a =Time.zone.parse("#{time_now.year}-04-01")
   @vacations =Vacation.where(user_id: @user_all.id).where(paid_vacation_day: time_a..time_now).order(paid_vacation_day: :desc)
   else
   time_b = Time.zone.parse("#{time_now.year - 1}-04-01")
   @vacations = Vacation.where(user_id:  @user_all.id).where(paid_vacation_day: time_b..time_now).order(paid_vacation_day: :desc)
   end
  end

  def self.paid_grant_day_all(user_id) #今年度有休消化日数
      @user_all = User.find_by(id: user_id)
      Vacation.paid_grant_working_day_all - Vacation.total_paid_holidays_all(user_id)
  end

  def self.paid_grant_working_day_all
      @working_days_id = @user_all.working_days_id
    if @working_days_id == 2
      return Vacation.paid_grant_all 
    elsif @working_days_id == 3
       paid_grant_day = Vacation.paid_grant_all * 0.75
      return paid_grant_day.floor
    elsif @working_days_id == 4
       paid_grant_day = Vacation.paid_grant_all * 0.58
      return paid_grant_day.floor
    elsif @working_days_id == 5
       paid_grant_day = Vacation.paid_grant_all * 0.38
      return paid_grant_day.floor
    else @working_days_id == 6
       paid_grant_day = Vacation.paid_grant_all * 0.19
      return paid_grant_day.floor
    end
  end

  def self.paid_grant_all  #今年の有給休暇計算
     @sum_month = Vacation.enrollment_period_all
     joining_day = @user_all.joining_day
     joining_day_month = joining_day.month
    if joining_day_month.between?(4, 9) #4月〜9月
       difference = joining_day_month - 4
      if @sum_month < 6
        return 0
      elsif @sum_month.between?(6, (11 - difference)) #半年
        return 10
      elsif (@sum_month + difference).between?(12, 23) #1年 
        return 11
      elsif (@sum_month + difference).between?(24, 35) #2年 
        return 12
      elsif (@sum_month + difference).between?(36, 47) #3年 
        return 14
      elsif (@sum_month + difference).between?(48, 59) #4年 
        return 16
      elsif (@sum_month + difference).between?(60, 71) #5年 
        return 18
      else
        return 20
    end

    elsif joining_day_month == 10  #10月
         difference = 6
    if @sum_month < 6 
      return 0
    elsif @sum_month.between?(6, (11 + difference)) #半年
      return 10
    elsif (@sum_month - difference).between?(12, 23) #1年 
      return 11
    elsif (@sum_month - difference).between?(24, 35) #2年 
      return 12
    elsif (@sum_month - difference).between?(36, 47) #3年 
      return 14
    elsif (@sum_month - difference).between?(48, 59) #4年 
      return 16
    elsif (@sum_month - difference).between?(60, 71) #5年 
      return 18
    else
      return 20
    end

    elsif joining_day_month == 11  #11月
    difference = 5
    if @sum_month < 6 
      return 0
    elsif @sum_month.between?(6, (11 + difference)) #半年
      return 10
    elsif (@sum_month - difference).between?(12, 23) #1年 
      return 11
    elsif (@sum_month - difference).between?(24, 35) #2年 
      return 12
    elsif (@sum_month - difference).between?(36, 47) #3年 
      return 14
    elsif (@sum_month - difference).between?(48, 59) #4年 
      return 16
    elsif (@sum_month - difference).between?(60, 71) #5年 
      return 18
    else
      return 20
    end

    elsif joining_day_month == 12  #12月
    difference = 4
    if @sum_month < 6 
      return 0
    elsif @sum_month.between?(6, (11 + difference)) #半年
      return 10
    elsif (@sum_month - difference).between?(12, 23) #1年 
      return 11
    elsif (@sum_month - difference).between?(24, 35) #2年 
      return 12
    elsif (@sum_month - difference).between?(36, 47) #3年 
      return 14
    elsif (@sum_month - difference).between?(48, 59) #4年 
      return 16
    elsif (@sum_month - difference).between?(60, 71) #5年 
      return 18
    else
      return 20
    end

    elsif joining_day_month == 1  #1月
    difference = 3
    if @sum_month < 6 
      return 0
    elsif @sum_month.between?(6, (11 + difference)) #半年
      return 10
    elsif (@sum_month - difference).between?(12, 23) #1年 
      return 11
    elsif (@sum_month - difference).between?(24, 35) #2年 
      return 12
    elsif (@sum_month - difference).between?(36, 47) #3年 
      return 14
    elsif (@sum_month - difference).between?(48, 59) #4年 
      return 16
    elsif (@sum_month - difference).between?(60, 71) #5年 
      return 18
    else
      return 20
    end
    
    elsif joining_day_month == 2  #2月
    difference = 2
    if @sum_month < 6 
      return 0
    elsif @sum_month.between?(6, (11 + difference)) #半年
      return 10
    elsif (@sum_month - difference).between?(12, 23) #1年 
      return 11
    elsif (@sum_month - difference).between?(24, 35) #2年 
      return 12
    elsif (@sum_month - difference).between?(36, 47) #3年 
      return 14
    elsif (@sum_month - difference).between?(48, 59) #4年 
      return 16
    elsif (@sum_month - difference).between?(60, 71) #5年 
      return 18
    else
      return 20
    end

    elsif joining_day_month == 3  #3月
    difference = 1
    if @sum_month < 6 
      return 0
    elsif @sum_month.between?(6, (11 + difference)) #半年
      return 10
    elsif (@sum_month - difference).between?(12, 23) #1年 
      return 11
    elsif (@sum_month - difference).between?(24, 35) #2年 
      return 12
    elsif (@sum_month - difference).between?(36, 47) #3年 
      return 14
    elsif (@sum_month - difference).between?(48, 59) #4年 
      return 16
    elsif (@sum_month - difference).between?(60, 71) #5年 
      return 18
    else
      return 20
    end
   end
  end

  def self.enrollment_period_all  #在籍日数
     date_today = Date.today
     joining_day = @user_all.joining_day
   if date_today.month - joining_day.month >= 0
      year = date_today.year - joining_day.year
      month = date_today.month - joining_day.month
   else
      year = date_today.year -  joining_day.year - 1
      month = date_today.month - joining_day.month + 12
   end
      sum_month = (year * 12) + month
  end

  def self.paid_grant_day_last_year_all(user_id) #昨年度有休消化日数
    @user_all = User.find_by(id: user_id)
    paid_g_d_l_y = Vacation.paid_grant_last_year_working_day_all - Vacation.total_paid_holidays_last_year_all
    if paid_g_d_l_y <= 0
       return 0
    else
       return paid_g_d_l_y
    end
  end

  def self.paid_grant_last_year_working_day_all
      @working_days_id = @user_all.working_days_id
   if @working_days_id == 2
    return Vacation.paid_grant_last_year_all
   elsif @working_days_id == 3
      paid_grant_day = Vacation.paid_grant_last_year_all * 0.75
    return  paid_grant_day.floor
   elsif @working_days_id == 4
      paid_grant_day = Vacation.paid_grant_last_year_all * 0.58
    return paid_grant_day.floor
   elsif @working_days_id == 5
      paid_grant_day = Vacation.paid_grant_last_year_all * 0.38
    return paid_grant_day.floor
   else @working_days_id == 6
      paid_grant_day = Vacation.paid_grant_last_year_all * 0.19
    return paid_grant_day.floor
   end
  end

  def self.paid_grant_last_year_all #昨年の有給休暇計算
    @sum_month = Vacation.enrollment_period_all
    joining_day = @user_all.joining_day
    joining_day_month = joining_day.month
    if joining_day_month.between?(4, 9) #4月〜9月
      difference = joining_day_month - 4
      if @sum_month < 6
        return 0
      elsif @sum_month.between?(6, (11 - difference)) #半年
        return 0
      elsif (@sum_month + difference).between?(12, 23) #1年 
        return 10
      elsif (@sum_month + difference).between?(24, 35) #2年 
        return 11
      elsif (@sum_month + difference).between?(36, 47) #3年 
        return 12
      elsif (@sum_month + difference).between?(48, 59) #4年 
        return 14
      elsif (@sum_month + difference).between?(60, 71) #5年 
        return 16
      elsif (@sum_month + difference).between?(72, 83) #6年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 10  #10月
      difference = 6
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 0
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 10
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 11
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 12
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 14
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 16
      elsif (@sum_month - difference).between?(72, 83) #6年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 11  #11月
      difference = 5
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 0
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 10
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 11
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 12
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 14
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 16
      elsif (@sum_month - difference).between?(72, 83) #6年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 12  #12月
      difference = 4
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 0
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 10
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 11
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 12
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 14
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 16
      elsif (@sum_month - difference).between?(72, 83) #6年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 1  #1月
      difference = 3
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 0
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 10
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 11
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 12
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 14
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 16
      elsif (@sum_month - difference).between?(72, 83) #6年 
        return 18
      else
        return 20
      end
      
    elsif joining_day_month == 2  #2月
      difference = 2
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 0
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 10
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 11
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 12
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 14
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 16
      elsif (@sum_month - difference).between?(72, 83) #6年 
        return 18
      else
        return 20
      end
  
    elsif joining_day_month == 3  #3月
      difference = 1
      if @sum_month < 6 
        return 0
      elsif @sum_month.between?(6, (11 + difference)) #半年
        return 0
      elsif (@sum_month - difference).between?(12, 23) #1年 
        return 10
      elsif (@sum_month - difference).between?(24, 35) #2年 
        return 11
      elsif (@sum_month - difference).between?(36, 47) #3年 
        return 12
      elsif (@sum_month - difference).between?(48, 59) #4年 
        return 14
      elsif (@sum_month - difference).between?(60, 71) #5年 
        return 16
      elsif (@sum_month - difference).between?(72, 83) #6年 
        return 18
      else
        return 20
      end
    end
  end

  def self.total_paid_holidays_last_year_all #昨年度の有給休暇の合計
    num = 0
    Vacation.vacation_same_one_last_year_all.each do |vacation|
     num += vacation.day
    end
    return num
  end

  def self.vacation_same_one_last_year_all #昨年度の有休消化を表示
    require "time"
    time_now = Time.new
    month_now = time_now.month
    if month_now.between?(4, 12)
    time_last_year_a =Time.zone.parse("#{time_now.year - 1}-04-01")
    time_now_year =Time.zone.parse("#{time_now.year}-3-31")
    @vacations_last_year =Vacation.where(user_id: @user_all.id).where(paid_vacation_day: time_last_year_a..time_now_year).order(paid_vacation_day: :desc)
    else
    time_last_year_b= Time.zone.parse("#{time_now.year - 2}-04-01")
    time_now_year =Time.zone.parse("#{time_now.year - 1}-03-31")
    @vacations_last_year = Vacation.where(user_id: @user_all.id).where(paid_vacation_day: time_last_year_b..time_now_year).order(paid_vacation_day: :desc)
    end
  end

end



