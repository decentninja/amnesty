class RoleAssignment < ActiveRecord::Base
  belongs_to :role
  belongs_to :student

  def self.current
    where('expires IS NULL OR expires < ?', Time.now)
  end
end
