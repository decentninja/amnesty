class StudentSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name
  has_many :privileges


  def privileges
    object.current_privileges
  end
end
