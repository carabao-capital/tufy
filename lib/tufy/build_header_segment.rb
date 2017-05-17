module Tufy
  class BuildHeaderSegment < BuildSegment
    expects :raw_data
    promises :transformed_data

    REQUIRED_KEYS = [
      :member_reference_number,
      :processor_name,
      :user_id
    ]

    executed do |ctx|
      validate_presence_of_required_keys(ctx.raw_data, REQUIRED_KEYS)
      ctx.transformed_data = ctx.transformed_data + transform(ctx).upcase
    end

    private

    def self.transform(ctx)
      Constants::SEGMENT_TAG + # Segment Tag (Required)
        Constants::TUDF_VERSION + # Version Tag (Required)
        "#{FormatStrings::F25TS % ctx.raw_data[:member_reference_number]}" + # Member Reference Number (Required)
        "#{FormatStrings::F26TS % ctx.raw_data[:processor_name].upcase}" + # Member Processor Name (Required)
        "#{FormatStrings::F10TS % ctx.raw_data[:user_id].upcase}" + # User ID (Required)
        "#{transform_date(Date.today)}" + # Reported Date (Required)
        Constants::FILLER # Filler (Required)
    end

    module Constants
      SEGMENT_TAG = "TUDF"
      TUDF_VERSION = "11"
      FILLER = "0000000000"
    end
  end
end
