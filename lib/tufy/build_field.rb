module Tufy
  class BuildField
    include LightService::Action

    protected

    def self.transform_date(date)
      # TODO: Remove conditional
      # after data-integrity issues
      # have been resolved
      date ? date.strftime("%d%m%Y") : "00000000"
    end

    def self.remove_special_characters(string)
      string.gsub(/[^0-9A-Za-z]/, '')
    end
  end
end
