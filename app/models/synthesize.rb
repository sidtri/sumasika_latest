class Synthesize < ActiveRecord::Base
	belongs_to :user
	has_one :event
end
