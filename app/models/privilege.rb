class Privilege < ActiveRecord::Base
  has_many :privilege_assignments, dependent: :destroy
  has_many :students, through: :privilege_assignments, source: :privileged, source_type: 'Student'
  has_many :roles, through: :privilege_assignments, source: :privileged, source_type: 'Role'


  def privileged
    students + roles
  end

  def assignable
    :privileged
  end

  def assign(assignee, expires = nil)
    fail AssignmentError if self.new_record?
    expires ||= expires_default
    PrivilegeAssignment.create(self.class.to_s.downcase.to_sym => self, assignable => assignee, expires: expires)
  end

  def expires_default
    Date.today + 1.months
  end

  def encode_json(_options = nil)
    name.to_json
  end
end
