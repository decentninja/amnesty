class StaticPagesController < ApplicationController
  skip_before_filter :authenticate!, :amnesty_admin
  def apidoc
  end
  def no_amnesty
  end
end
