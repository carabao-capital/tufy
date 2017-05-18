module Tufy
  class BuildContactNumberSegment < BuildSegment
    expects :raw_data
    promises :transformed_data

    REQUIRED_KEYS = [
      :contact_number,
      :contact_number_format,
    ]

    executed do |ctx|
      validate_presence_of_required_keys(ctx.raw_data, REQUIRED_KEYS)
      ctx.transformed_data = ctx.transformed_data + transform(ctx).upcase
    end

    private

    def self.transform(ctx)
      raw_data = ctx[:raw_data]

      Constants::SEGMENT_TAG + # Segment Tag (Required)
        Constants::CONTACT_NUMBER_TAG +
          FormatStrings::F2TS % remove_special_characters(raw_data[:contact_number]).size +
            remove_special_characters(raw_data[:contact_number]) + # Contact Number (Required)
        Constants::CONTACT_NUMBER_FORMAT_TAG +
          FormatStrings::F2TS % raw_data[:contact_number_format].size +
            raw_data[:contact_number_format] # Contact Number Format (Required)
    end

    module Constants
      # tags
      SEGMENT_TAG = "PH03P01"
      CONTACT_NUMBER_TAG = "03"
      CONTACT_NUMBER_FORMAT_TAG = "05"

      # contact number format constants
      FREE_FORMAT = "F"
      STRUCTURED_FORMAT = "S"
    end
  end
end
