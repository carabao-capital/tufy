module Tufy
  module Fields
    module Account
      class BuildPaymentFrequencyField < BuildField
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

          BuildAccountSegment::Constants::PAYMENT_FREQUENCY_TAG +
            FormatStrings::F2TS % raw_data[:payment_frequency].size +
            raw_data[:payment_frequency]
        end
      end
    end
  end
end
