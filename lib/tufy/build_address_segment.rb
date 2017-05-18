module Tufy
  class BuildAddressSegment < BuildSegment
    expects :raw_data
    promises :transformed_data

    REQUIRED_KEYS = [
      :address_line_1,
      :address_line_2,
      :address_type,
    ]

    executed do |ctx|
      validate_presence_of_required_keys(ctx.raw_data, REQUIRED_KEYS)
      ctx.transformed_data = ctx.transformed_data + transform(ctx).upcase
    end

    private

    def self.transform(ctx)
      raw_data = ctx[:raw_data]

      Constants::SEGMENT_TAG + # Segment Tag (Required)
        Constants::ADDRESS_LINE_1_TAG +
          FormatStrings::F2TS % remove_special_characters(raw_data[:address_line_1]).size +
            remove_special_characters(raw_data[:address_line_1]) + # Address Line 1 (Required)
        Constants::ADDRESS_LINE_2_TAG +
          FormatStrings::F2TS % remove_special_characters(raw_data[:address_line_2]).size +
            remove_special_characters(raw_data[:address_line_2]) + # Address Line 2 (Required)
        Constants::ADDRESS_TYPE_TAG +
          FormatStrings::F2TS % raw_data[:address_type].size +
            raw_data[:address_type] # Address Type (Required)
    end

    module Constants
      # tags
      SEGMENT_TAG = "AL03A01"
      ADDRESS_LINE_1_TAG = "01"
      ADDRESS_LINE_2_TAG = "02"
      ADDRESS_TYPE_TAG = "07"

      # address type constants
      RESIDENTIAL = "R"
      OFFICE = "F"
      BILLING_ADDRESS = "B"
      OTHERS = "O"
      UNKNOWN = "U"
    end
  end
end
