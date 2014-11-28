require 'dfunkt/positions'

# Motsvarande Oficially appointed functions as tracked by Dfunkt
class Position < ActiveRecord::Base
  has_and_belongs_to_many :roles

  def privileges
    roles.flat_map(&:current_privileges)
  end

  def self.positions_for(ugid)
    DFUNKT::Positions.fetch(ugid)
  end

  def students
  	roles.map(&:students).flatten
  end
end
