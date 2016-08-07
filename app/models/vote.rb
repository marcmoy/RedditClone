class Vote < ActiveRecord::Base
  validates :value, inclusion: { in: [-1,0,1] }

  belongs_to :votable, polymorphic: :true
end
