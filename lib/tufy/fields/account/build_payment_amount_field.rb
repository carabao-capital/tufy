module Tufy
  module Fields
    module Account
      class BuildPaymentAmountField < BuildField
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

          BuildAccountSegment::Constants::PAYMENT_AMOUNT_TAG +
            FormatStrings::F2TS % raw_data[:payment_amount].to_i.to_s.size +
            raw_data[:payment_amount].to_i.to_s
        end
      end
    end
  end
end
