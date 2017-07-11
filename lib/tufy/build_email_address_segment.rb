module Tufy
  class BuildEmailAddressSegment < BuildSegment
    expects :raw_data
    promises :transformed_data

    REQUIRED_KEYS = [
      :email_address,
    ]

    executed do |ctx|
      validate_presence_of_required_keys(ctx.raw_data, REQUIRED_KEYS)
      ctx.transformed_data = ctx.transformed_data + transform(ctx).upcase
    end

    private

    def self.transform(ctx)
      raw_data = ctx[:raw_data]

      result = Fields::EmailAddress::BuildEmailAddressField.execute(ctx)

      Constants::SEGMENT_TAG + result[:transformed_data]
    end

    module Constants
      # tags
      SEGMENT_TAG = "ID03I01"
      EMAIL_ADDRESS_TAG = "01"
    end
  end
end
