class PrivilegeAssignment < ActiveRecord::Base
  belongs_to :privilege
  belongs_to :privileged, polymorphic: true
end
