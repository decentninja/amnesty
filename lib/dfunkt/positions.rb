module DFUNKT
  class Positions
    def fetch(ugid)
      poll_dfunkt(ugid).map do |dfunkt_id|
        Position.find_by_dfunkt_id(dfunkt_id)
      end
    end

    private

    def poll_dfunkt(ugid)
      [1,2,3]
    end
  end
end
