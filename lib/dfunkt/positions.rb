module DFUNKT
  class Positions
    def self.fetch(ugid)
      poll_dfunkt(ugid).map do |dfunkt_id|
        Position.find_by_dfunkt_id(dfunkt_id)
      end.reject(&:blank?)
    end

    def self.poll_dfunkt(_ugid)
      ["ordf","vordf","info"]
    end
  end
end
