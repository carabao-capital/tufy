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

      result = with(ctx).reduce(
        Fields::Address::BuildAddress1Field,
        Fields::Address::BuildAddress2Field,
        Fields::Address::BuildAddressTypeField,
      )

      Constants::SEGMENT_TAG + result[:transformed_data]
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
