module Tufy
  module Fields
    module Account
      class BuildPartialPaymentField < BuildField
        expects :raw_data
        promises :transformed_data

        executed do |ctx|
          if ctx.raw_data[:partial_payment]
            ctx.transformed_data =
              ctx.transformed_data +
              transform(ctx).upcase
          end
        end

        private

        def self.transform(ctx)
          raw_data = ctx.raw_data

          BuildAccountSegment::Constants::PARTIAL_PAYMENT_TAG +
            FormatStrings::F2TS % raw_data[:partial_payment].size +
            raw_data[:partial_payment]
        end
      end
    end
  end
end
