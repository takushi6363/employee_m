class WorkingDays < ActiveHash::Base
  self.data = [
    { id: 1, name: '有給休暇の日数の選択' },
    { id: 2, name: '正職員（5日勤務）' },
    { id: 3, name: '有給日数 4/5' },
    { id: 4, name: '有給日数 3/5' },
    { id: 5, name: '有給日数 2/5' },
    { id: 6, name: '有給日数 1/5' },
  ]

  include ActiveHash::Associations
  has_many :users

  end