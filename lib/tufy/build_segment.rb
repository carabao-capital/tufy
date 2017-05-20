module Tufy
  class BuildSegment
    include LightService::Action

    protected

    def self.validate_presence_of_required_keys(raw_data, required_keys)
      required_keys.each do |required_key|
        raise Tufy::Errors::RequiredDataMissing, required_key.to_s unless raw_data.key? required_key
      end
    end

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
