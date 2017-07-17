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
      ctx.transformed_data = transform(ctx).upcase
    end

    private

    def self.transform(ctx)
      ctx[:segment_tag] = Constants::SEGMENT_TAG

      result = with(ctx).reduce(
        Fields::BuildSegmentTagField,
        Fields::ContactNumber::BuildContactNumberField,
        Fields::ContactNumber::BuildContactNumberFormatField,
      )

      result[:transformed_data]
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
