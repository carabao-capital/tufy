module Tufy
  class BuildHeaderSegment < BuildSegment
    expects :header_data
    promises :transformed_data

    REQUIRED_KEYS = [
      :processor_name,
      :user_id,
      :reported_date,
    ]

    executed do |ctx|
      validate_presence_of_required_keys(ctx.header_data, REQUIRED_KEYS)
      ctx.transformed_data = ctx.transformed_data + transform(ctx).upcase
    end

    private

    def self.transform(ctx)
      Constants::SEGMENT_TAG + # Segment Tag (Required)
        Constants::TUDF_VERSION + # Version Tag (Required)
        "#{FormatStrings::F25TS % Time.now.to_i.to_s}" + # Member Reference Number (Required)
        "#{FormatStrings::F26TS % ctx.header_data[:processor_name].upcase}" + # Member Processor Name (Required)
        "#{FormatStrings::F10TS % ctx.header_data[:user_id].upcase}" + # User ID (Required)
        "#{BuildField.transform_date(ctx.header_data[:reported_date])}" + # Reported Date (Required)
        Constants::FILLER # Filler (Required)
    end

    module Constants
      SEGMENT_TAG = "TUDF"
      TUDF_VERSION = "11"
      FILLER = "0000000000"
    end
  end
end
