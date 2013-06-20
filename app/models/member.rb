class Member < ActiveRecord::Base
  attr_accessible :name, :email, :at_home
end
