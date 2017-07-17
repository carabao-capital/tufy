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
      ctx.transformed_data = transform(ctx).upcase
    end

    private

    def self.transform(ctx)
      ctx[:segment_tag] = Constants::SEGMENT_TAG

      result = with(ctx).reduce(
        Fields::BuildSegmentTagField,
        Fields::Address::BuildAddress1Field,
        Fields::Address::BuildAddress2Field,
        Fields::Address::BuildAddressTypeField,
      )

      result[:transformed_data]
    end

    module Constants
      # tags
      SEGMENT_TAG = "PA03A01"
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
