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

      Constants::SEGMENT_TAG + # Segment Tag (Required)
        Constants::EMAIL_ADDRESS_TAG +
          FormatStrings::F2TS % raw_data[:email_address].size +
            raw_data[:email_address] # Email Address (Required)
    end

    module Constants
      # tags
      SEGMENT_TAG = "ID03I01"
      EMAIL_ADDRESS_TAG = "01"
    end
  end
end
