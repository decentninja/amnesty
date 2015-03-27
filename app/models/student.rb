# Student, person, cal them what you like.
class Student < ActiveRecord::Base
  include LDAPLookup::Importable
  has_many :privilege_assignments, as: :privileged, dependent: :destroy
  has_many :privileges, through: :privilege_assignments do
    def current
      where('privilege_assignments.expires IS NULL OR privilege_assignments.expires >= ?', Date.today)
    end
  end

  has_many :role_assignments, dependent: :destroy
  has_many :roles, through: :role_assignments do
    def current
      where('role_assignments.expires IS NULL OR role_assignments.expires >= ?', Date.today)
    end
  end

  def positions
    Position.positions_for(ugid)
  end

  def current_privileges
    privileges.current.to_a +
      roles.current.flat_map(&:current_privileges) +
      Position.positions_for(ugid).flat_map(&:privileges)
  end

  def current_privilege_names
    current_privileges.map(&:name)
  end

  def as_json(_options = nil)
    current_privileges
  end

  def self.find_or_create_from_ldap(options = {})
    return nil unless options[:ugid].present?
    Student.where(options).first || from_ldap(options).tap { |u| u.save }
  end
end
