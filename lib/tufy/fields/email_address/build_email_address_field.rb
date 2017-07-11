module Tufy
  module Fields
    module EmailAddress
      class BuildEmailAddressField < BuildField
        expects :raw_data
        promises :transformed_data

        executed do |ctx|
          ctx.transformed_data =
            ctx.transformed_data +
            transform(ctx).upcase
        end

        private

        def self.transform(ctx)
          raw_data = ctx.raw_data

          BuildEmailAddressSegment::Constants::EMAIL_ADDRESS_TAG +
            FormatStrings::F2TS % raw_data[:email_address].size +
              raw_data[:email_address]
        end
      end
    end
  end
end
