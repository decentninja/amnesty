class Role < ActiveRecord::Base
  has_many :role_assignments, dependent: :destroy
  has_many :role_holders, through: :role_assignments, source: :student do
    def current
      where('role_assignments.expires IS NULL OR role_assignments.expires >= ?', Date.today)
    end
  end

  has_many :privilege_assignments, as: :privileged
  has_many :privileges, through: :privilege_assignments do
    def current
      where('privilege_assignments.expires IS NULL OR privilege_assignments.expires >= ?', Date.today)
    end
  end

  def current_privileges
    privileges.current.to_a
  end

  has_and_belongs_to_many :positions

  def assign(student, expires = nil)
    expires ||= expires_default
    RoleAssignment.create(role: self, student: student, expires: expires)
  end

  def remove(student)
    assignment(student).expires = Date.yesterday
  end

  def students
    role_assignments.map &:student
  end

  def assignment(student)
    role_assignments.find_by_student_id(student.id)
  end

  def expires_default
    expires = Date.today.change(month: default_term_end)
    expires + 1.year if expires < Date.today + 1.month
  end
end
