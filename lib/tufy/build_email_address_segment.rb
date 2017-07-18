module Tufy
  class BuildEmailAddressSegment < BuildSegment
    expects :raw_data
    promises :transformed_data

    REQUIRED_KEYS = [
      :email_address,
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
        Fields::EmailAddress::BuildEmailAddressField,
      )

      result[:transformed_data]
    end

    module Constants
      # tags
      SEGMENT_TAG = "EA03E01"
      EMAIL_ADDRESS_TAG = "01"
    end
  end
end
