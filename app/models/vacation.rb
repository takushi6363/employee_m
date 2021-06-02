class Vacation < ApplicationRecord
  belongs_to :user

  validates :day, presence: true
  validates :paid_vacation_day, presence: true

  def self.user_id_new(user_id)
    @user_id = user_id
  end

  def self.joiningday(joining_day)
    @joining_day_month = joining_day.month
  end

  def self.working_days_id_new(working_days_id)
    @working_days_id = working_days_id
  end

  # 年度表示に使用
  def self.business_year
    require 'time'
    time_now = Time.new
    month = time_now.month
    if month.between?(4, 12)
      time_now.year
    else
      time_now.year - 1
    end
  end

  # 年度内の有給消化を表示
  def self.vacation_same_one
    require 'time'
    time_now = Time.new
    month_now = time_now.month
    if month_now.between?(4, 12)
      time_a = Time.zone.parse("#{time_now.year}-04-01")
      @vacations = Vacation.where(user_id: @user_id).where(paid_vacation_day: time_a..time_now).order(paid_vacation_day: :desc)
    else
      time_b = Time.zone.parse("#{time_now.year - 1}-04-01")
      @vacations = Vacation.where(user_id: @user_id).where(paid_vacation_day: time_b..time_now).order(paid_vacation_day: :desc)
    end
  end

  # 昨年度の有休消化を表示
  def self.vacation_same_one_last_year
    require 'time'
    time_now = Time.new
    month_now = time_now.month
    if month_now.between?(4, 12)
      time_last_year_a = Time.zone.parse("#{time_now.year - 1}-04-01")
      time_now_year = Time.zone.parse("#{time_now.year}-3-31")
      @vacations_last_year = Vacation.where(user_id: @user_id).where(paid_vacation_day: time_last_year_a..time_now_year).order(paid_vacation_day: :desc)
    else
      time_last_year_b = Time.zone.parse("#{time_now.year - 2}-04-01")
      time_now_year = Time.zone.parse("#{time_now.year - 1}-03-31")
      @vacations_last_year = Vacation.where(user_id: @user_id).where(paid_vacation_day: time_last_year_b..time_now_year).order(paid_vacation_day: :desc)
    end
  end

  # 在籍日数
  def self.enrollment_period
    user = User.find_by(id: @user_id)
    date_today = Date.today
    joining_day = user.joining_day
    if date_today.month - joining_day.month >= 0
      year = date_today.year - joining_day.year
      month = date_today.month - joining_day.month
    else
      year = date_today.year - joining_day.year - 1
      month = date_today.month - joining_day.month + 12
    end
    sum_month = (year * 12) + month
  end

  # 今年の有給休暇計算
  def self.paid_grant
    sum_month = Vacation.enrollment_period
    joining_day_month = @joining_day_month
    if joining_day_month.between?(4, 9) # 4月〜9月
      difference = joining_day_month - 4
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 - difference)) # 半年
        10
      elsif (sum_month + difference).between?(12, 23) # 1年
        11
      elsif (sum_month + difference).between?(24, 35) # 2年
        12
      elsif (sum_month + difference).between?(36, 47) # 3年
        14
      elsif (sum_month + difference).between?(48, 59) # 4年
        16
      elsif (sum_month + difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 10 # 10月
      difference = 6
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 11 # 11月
      difference = 5
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 12 # 12月
      difference = 4
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 1 # 1月
      difference = 3
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 2 # 2月
      difference = 2
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 3 # 3月
      difference = 1
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end

    end
  end

  # 昨年の有給休暇計算
  def self.paid_grant_last_year
    sum_month = Vacation.enrollment_period
    joining_day_month = @joining_day_month
    if joining_day_month.between?(4, 9) # 4月〜9月
      difference = joining_day_month - 4
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 - difference)) # 半年
        0
      elsif (sum_month + difference).between?(12, 23) # 1年
        10
      elsif (sum_month + difference).between?(24, 35) # 2年
        11
      elsif (sum_month + difference).between?(36, 47) # 3年
        12
      elsif (sum_month + difference).between?(48, 59) # 4年
        14
      elsif (sum_month + difference).between?(60, 71) # 5年
        16
      elsif (sum_month + difference).between?(72, 83) # 6年
        18
      else
        20
      end

    elsif joining_day_month == 10 # 10月
      difference = 6
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        0
      elsif (sum_month - difference).between?(12, 23) # 1年
        10
      elsif (sum_month - difference).between?(24, 35) # 2年
        11
      elsif (sum_month - difference).between?(36, 47) # 3年
        12
      elsif (sum_month - difference).between?(48, 59) # 4年
        14
      elsif (sum_month - difference).between?(60, 71) # 5年
        16
      elsif (sum_month - difference).between?(72, 83) # 6年
        18
      else
        20
      end

    elsif joining_day_month == 11 # 11月
      difference = 5
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        0
      elsif (sum_month - difference).between?(12, 23) # 1年
        10
      elsif (sum_month - difference).between?(24, 35) # 2年
        11
      elsif (sum_month - difference).between?(36, 47) # 3年
        12
      elsif (sum_month - difference).between?(48, 59) # 4年
        14
      elsif (sum_month - difference).between?(60, 71) # 5年
        16
      elsif (sum_month - difference).between?(72, 83) # 6年
        18
      else
        20
      end

    elsif joining_day_month == 12 # 12月
      difference = 4
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        0
      elsif (sum_month - difference).between?(12, 23) # 1年
        10
      elsif (sum_month - difference).between?(24, 35) # 2年
        11
      elsif (sum_month - difference).between?(36, 47) # 3年
        12
      elsif (sum_month - difference).between?(48, 59) # 4年
        14
      elsif (sum_month - difference).between?(60, 71) # 5年
        16
      elsif (sum_month - difference).between?(72, 83) # 6年
        18
      else
        20
      end

    elsif joining_day_month == 1 # 1月
      difference = 3
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        0
      elsif (sum_month - difference).between?(12, 23) # 1年
        10
      elsif (sum_month - difference).between?(24, 35) # 2年
        11
      elsif (sum_month - difference).between?(36, 47) # 3年
        12
      elsif (sum_month - difference).between?(48, 59) # 4年
        14
      elsif (sum_month - difference).between?(60, 71) # 5年
        16
      elsif (sum_month - difference).between?(72, 83) # 6年
        18
      else
        20
      end

    elsif joining_day_month == 2 # 2月
      difference = 2
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        0
      elsif (sum_month - difference).between?(12, 23) # 1年
        10
      elsif (sum_month - difference).between?(24, 35) # 2年
        11
      elsif (sum_month - difference).between?(36, 47) # 3年
        12
      elsif (sum_month - difference).between?(48, 59) # 4年
        14
      elsif (sum_month - difference).between?(60, 71) # 5年
        16
      elsif (sum_month - difference).between?(72, 83) # 6年
        18
      else
        20
      end

    elsif joining_day_month == 3 # 3月
      difference = 1
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        0
      elsif (sum_month - difference).between?(12, 23) # 1年
        10
      elsif (sum_month - difference).between?(24, 35) # 2年
        11
      elsif (sum_month - difference).between?(36, 47) # 3年
        12
      elsif (sum_month - difference).between?(48, 59) # 4年
        14
      elsif (sum_month - difference).between?(60, 71) # 5年
        16
      elsif (sum_month - difference).between?(72, 83) # 6年
        18
      else
        20
      end
    end
  end

  # 今年度の有給休暇の合計
  def self.total_paid_holidays
    num = 0
    Vacation.vacation_same_one.each do |vacation|
      num += vacation.day
    end
    num
  end

  # 昨年度の有給休暇の合計
  def self.total_paid_holidays_last_year
    num = 0
    Vacation.vacation_same_one_last_year.each do |vacation|
      num += vacation.day
    end
    num
  end

  def self.paid_grant_working_day
    if @working_days_id == 2
      Vacation.paid_grant
    elsif @working_days_id == 3
      paid_grant_day = Vacation.paid_grant * 0.75
      paid_grant_day.floor
    elsif @working_days_id == 4
      paid_grant_day = Vacation.paid_grant * 0.58
      paid_grant_day.floor
    elsif @working_days_id == 5
      paid_grant_day = Vacation.paid_grant * 0.38
      paid_grant_day.floor
    else
      @working_days_id == 6
      paid_grant_day = Vacation.paid_grant * 0.19
      paid_grant_day.floor
    end
  end

  def self.paid_grant_last_year_working_day
    if @working_days_id == 2
      Vacation.paid_grant_last_year
    elsif @working_days_id == 3
      paid_grant_day = Vacation.paid_grant_last_year * 0.75
      paid_grant_day.floor
    elsif @working_days_id == 4
      paid_grant_day = Vacation.paid_grant_last_year * 0.58
      paid_grant_day.floor
    elsif @working_days_id == 5
      paid_grant_day = Vacation.paid_grant_last_year * 0.38
      paid_grant_day.floor
    else
      @working_days_id == 6
      paid_grant_day = Vacation.paid_grant_last_year * 0.19
      paid_grant_day.floor
    end
  end

  # 今年度有休消化日数
  def self.paid_grant_day
    Vacation.paid_grant_working_day - Vacation.total_paid_holidays
  end

  # 昨年度有休消化日数
  def self.paid_grant_day_last_year
    paid_g_d_l_y = Vacation.paid_grant_last_year_working_day - Vacation.total_paid_holidays_last_year
    if paid_g_d_l_y <= 0
      0
    else
      paid_g_d_l_y
    end
  end

  # 検索時の有休消化表示

  # 在籍日数
  def self.enrollment_period_search(year)
    user = User.find_by(id: @user_id)
    @year = year
    date_today = Date.today
    joining_day = user.joining_day
    date_today = Time.zone.parse("#{@year}-04-01")
    joining_day_year = @joining_day_year.to_i
    if date_today.month - joining_day.month >= 0
      year = date_today.year - joining_day.year
      month = date_today.month - joining_day.month
    else
      year = date_today.year - joining_day.year - 1
      month = date_today.month - joining_day.month + 12
    end
    sum_month = (year * 12) + month
  end

  # 今年の有給休暇計算
  def self.paid_grant_search
    sum_month = Vacation.enrollment_period_search(@year)
    joining_day_month = @joining_day_month
    if joining_day_month.between?(4, 9) # 4月〜9月
      difference = joining_day_month - 4
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 - difference)) # 半年
        10
      elsif (sum_month + difference).between?(12, 23) # 1年
        11
      elsif (sum_month + difference).between?(24, 35) # 2年
        12
      elsif (sum_month + difference).between?(36, 47) # 3年
        14
      elsif (sum_month + difference).between?(48, 59) # 4年
        16
      elsif (sum_month + difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 10 # 10月
      difference = 6
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 11 # 11月
      difference = 5
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 12 # 12月
      difference = 4
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 1 # 1月
      difference = 3
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 2 # 2月
      difference = 2
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 3 # 3月
      difference = 1
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end

    end
  end

  def self.paid_grant_working_day_search
    if @working_days_id == 2
      Vacation.paid_grant_search
    elsif @working_days_id == 3
      paid_grant_day_search = Vacation.paid_grant_search * 0.75
      paid_grant_day_search.floor
    elsif @working_days_id == 4
      paid_grant_day_search = Vacation.paid_grant_search * 0.58
      paid_grant_day_search.floor
    elsif @working_days_id == 5
      paid_grant_day_search = Vacation.paid_grant_search * 0.38
      paid_grant_day_search.floor
    else
      @working_days_id == 6
      paid_grant_day_search = Vacation.paid_grant_search * 0.19
      paid_grant_day_search.floor
    end
  end

  # 社員一覧の有給休暇

  # 今年度の有給休暇の合計
  def self.total_paid_holidays_all(user_id)
    @user_all = User.find_by(id: user_id)
    num = 0
    Vacation.vacation_same_one_all.each do |vacation|
      num += vacation.day
    end
    num
  end

  # 年度内の有給消化を表示
  def self.vacation_same_one_all
    require 'time'
    time_now = Time.new
    month_now = time_now.month
    if month_now.between?(4, 12)
      time_a = Time.zone.parse("#{time_now.year}-04-01")
      @vacations = Vacation.where(user_id: @user_all.id).where(paid_vacation_day: time_a..time_now).order(paid_vacation_day: :desc)
    else
      time_b = Time.zone.parse("#{time_now.year - 1}-04-01")
      @vacations = Vacation.where(user_id: @user_all.id).where(paid_vacation_day: time_b..time_now).order(paid_vacation_day: :desc)
    end
  end

  # 今年度有休消化日数
  def self.paid_grant_day_all(user_id)
    @user_all = User.find_by(id: user_id)
    Vacation.paid_grant_working_day_all - Vacation.total_paid_holidays_all(user_id)
  end

  def self.paid_grant_working_day_all
    @working_days_id = @user_all.working_days_id
    if @working_days_id == 2
      Vacation.paid_grant_all
    elsif @working_days_id == 3
      paid_grant_day = Vacation.paid_grant_all * 0.75
      paid_grant_day.floor
    elsif @working_days_id == 4
      paid_grant_day = Vacation.paid_grant_all * 0.58
      paid_grant_day.floor
    elsif @working_days_id == 5
      paid_grant_day = Vacation.paid_grant_all * 0.38
      paid_grant_day.floor
    else
      @working_days_id == 6
      paid_grant_day = Vacation.paid_grant_all * 0.19
      paid_grant_day.floor
    end
  end

  # 今年の有給休暇計算
  def self.paid_grant_all
    sum_month = Vacation.enrollment_period_all
    joining_day = @user_all.joining_day
    joining_day_month = joining_day.month
    if joining_day_month.between?(4, 9) # 4月〜9月
      difference = joining_day_month - 4
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 - difference)) # 半年
        10
      elsif (sum_month + difference).between?(12, 23) # 1年
        11
      elsif (sum_month + difference).between?(24, 35) # 2年
        12
      elsif (sum_month + difference).between?(36, 47) # 3年
        14
      elsif (sum_month + difference).between?(48, 59) # 4年
        16
      elsif (sum_month + difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 10 # 10月
      difference = 6
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 11 # 11月
      difference = 5
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 12 # 12月
      difference = 4
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 1 # 1月
      difference = 3
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 2 # 2月
      difference = 2
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end

    elsif joining_day_month == 3 # 3月
      difference = 1
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        10
      elsif (sum_month - difference).between?(12, 23) # 1年
        11
      elsif (sum_month - difference).between?(24, 35) # 2年
        12
      elsif (sum_month - difference).between?(36, 47) # 3年
        14
      elsif (sum_month - difference).between?(48, 59) # 4年
        16
      elsif (sum_month - difference).between?(60, 71) # 5年
        18
      else
        20
      end
    end
  end

  # 在籍日数
  def self.enrollment_period_all
    date_today = Date.today
    joining_day = @user_all.joining_day
    if date_today.month - joining_day.month >= 0
      year = date_today.year - joining_day.year
      month = date_today.month - joining_day.month
    else
      year = date_today.year - joining_day.year - 1
      month = date_today.month - joining_day.month + 12
    end
    sum_month = (year * 12) + month
  end

  # 昨年度有休消化日数
  def self.paid_grant_day_last_year_all(user_id)
    @user_all = User.find_by(id: user_id)
    paid_g_d_l_y = Vacation.paid_grant_last_year_working_day_all - Vacation.total_paid_holidays_last_year_all
    if paid_g_d_l_y <= 0
      0
    else
      paid_g_d_l_y
    end
  end

  def self.paid_grant_last_year_working_day_all
    @working_days_id = @user_all.working_days_id
    if @working_days_id == 2
      Vacation.paid_grant_last_year_all
    elsif @working_days_id == 3
      paid_grant_day = Vacation.paid_grant_last_year_all * 0.75
      paid_grant_day.floor
    elsif @working_days_id == 4
      paid_grant_day = Vacation.paid_grant_last_year_all * 0.58
      paid_grant_day.floor
    elsif @working_days_id == 5
      paid_grant_day = Vacation.paid_grant_last_year_all * 0.38
      paid_grant_day.floor
    else
      @working_days_id == 6
      paid_grant_day = Vacation.paid_grant_last_year_all * 0.19
      paid_grant_day.floor
    end
  end

  # 昨年の有給休暇計算
  def self.paid_grant_last_year_all
    sum_month = Vacation.enrollment_period_all
    joining_day = @user_all.joining_day
    joining_day_month = joining_day.month
    if joining_day_month.between?(4, 9) # 4月〜9月
      difference = joining_day_month - 4
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 - difference)) # 半年
        0
      elsif (sum_month + difference).between?(12, 23) # 1年
        10
      elsif (sum_month + difference).between?(24, 35) # 2年
        11
      elsif (sum_month + difference).between?(36, 47) # 3年
        12
      elsif (sum_month + difference).between?(48, 59) # 4年
        14
      elsif (sum_month + difference).between?(60, 71) # 5年
        16
      elsif (sum_month + difference).between?(72, 83) # 6年
        18
      else
        20
      end

    elsif joining_day_month == 10 # 10月
      difference = 6
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        0
      elsif (sum_month - difference).between?(12, 23) # 1年
        10
      elsif (sum_month - difference).between?(24, 35) # 2年
        11
      elsif (sum_month - difference).between?(36, 47) # 3年
        12
      elsif (sum_month - difference).between?(48, 59) # 4年
        14
      elsif (sum_month - difference).between?(60, 71) # 5年
        16
      elsif (sum_month - difference).between?(72, 83) # 6年
        18
      else
        20
      end

    elsif joining_day_month == 11 # 11月
      difference = 5
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        0
      elsif (sum_month - difference).between?(12, 23) # 1年
        10
      elsif (sum_month - difference).between?(24, 35) # 2年
        11
      elsif (sum_month - difference).between?(36, 47) # 3年
        12
      elsif (sum_month - difference).between?(48, 59) # 4年
        14
      elsif (sum_month - difference).between?(60, 71) # 5年
        16
      elsif (sum_month - difference).between?(72, 83) # 6年
        18
      else
        20
      end

    elsif joining_day_month == 12 # 12月
      difference = 4
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        0
      elsif (sum_month - difference).between?(12, 23) # 1年
        10
      elsif (sum_month - difference).between?(24, 35) # 2年
        11
      elsif (sum_month - difference).between?(36, 47) # 3年
        12
      elsif (sum_month - difference).between?(48, 59) # 4年
        14
      elsif (sum_month - difference).between?(60, 71) # 5年
        16
      elsif (sum_month - difference).between?(72, 83) # 6年
        18
      else
        20
      end

    elsif joining_day_month == 1 # 1月
      difference = 3
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        0
      elsif (sum_month - difference).between?(12, 23) # 1年
        10
      elsif (sum_month - difference).between?(24, 35) # 2年
        11
      elsif (sum_month - difference).between?(36, 47) # 3年
        12
      elsif (sum_month - difference).between?(48, 59) # 4年
        14
      elsif (sum_month - difference).between?(60, 71) # 5年
        16
      elsif (sum_month - difference).between?(72, 83) # 6年
        18
      else
        20
      end

    elsif joining_day_month == 2 # 2月
      difference = 2
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        0
      elsif (sum_month - difference).between?(12, 23) # 1年
        10
      elsif (sum_month - difference).between?(24, 35) # 2年
        11
      elsif (sum_month - difference).between?(36, 47) # 3年
        12
      elsif (sum_month - difference).between?(48, 59) # 4年
        14
      elsif (sum_month - difference).between?(60, 71) # 5年
        16
      elsif (sum_month - difference).between?(72, 83) # 6年
        18
      else
        20
      end

    elsif joining_day_month == 3 # 3月
      difference = 1
      if sum_month < 6
        0
      elsif sum_month.between?(6, (11 + difference)) # 半年
        0
      elsif (sum_month - difference).between?(12, 23) # 1年
        10
      elsif (sum_month - difference).between?(24, 35) # 2年
        11
      elsif (sum_month - difference).between?(36, 47) # 3年
        12
      elsif (sum_month - difference).between?(48, 59) # 4年
        14
      elsif (sum_month - difference).between?(60, 71) # 5年
        16
      elsif (sum_month - difference).between?(72, 83) # 6年
        18
      else
        20
      end
    end
  end

  # 昨年度の有給休暇の合計
  def self.total_paid_holidays_last_year_all
    num = 0
    Vacation.vacation_same_one_last_year_all.each do |vacation|
      num += vacation.day
    end
    num
  end

  # 昨年度の有休消化を表示
  def self.vacation_same_one_last_year_all
    require 'time'
    time_now = Time.new
    month_now = time_now.month
    if month_now.between?(4, 12)
      time_last_year_a = Time.zone.parse("#{time_now.year - 1}-04-01")
      time_now_year = Time.zone.parse("#{time_now.year}-3-31")
      @vacations_last_year = Vacation.where(user_id: @user_all.id).where(paid_vacation_day: time_last_year_a..time_now_year).order(paid_vacation_day: :desc)
    else
      time_last_year_b = Time.zone.parse("#{time_now.year - 2}-04-01")
      time_now_year = Time.zone.parse("#{time_now.year - 1}-03-31")
      @vacations_last_year = Vacation.where(user_id: @user_all.id).where(paid_vacation_day: time_last_year_b..time_now_year).order(paid_vacation_day: :desc)
    end
  end
end
