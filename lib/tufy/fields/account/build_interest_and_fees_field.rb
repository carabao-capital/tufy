module Tufy
  module Fields
    module Account
      class BuildInterestAndFeesField < BuildField
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

          interest_and_fees = raw_data[:interest_and_fees].to_i
          interest_and_fees = interest_and_fees < 0 ? 0 : interest_and_fees

          BuildAccountSegment::Constants::INTEREST_AND_FEES_TAG +
            FormatStrings::F2TS % interest_and_fees.to_s.size +
              interest_and_fees.to_s
        end
      end
    end
  end
end
