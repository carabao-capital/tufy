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
      date.strftime("%d%m%Y")
    end
  end
end
