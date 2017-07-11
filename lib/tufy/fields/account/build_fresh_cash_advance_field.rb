module Tufy
  module Fields
    module Account
      class BuildFreshCashAdvanceField < BuildField
        expects :raw_data
        promises :transformed_data

        executed do |ctx|
          if ctx.raw_data[:fresh_cash_advance]
            ctx.transformed_data =
              ctx.transformed_data +
              transform(ctx).upcase
          end
        end

        private

        def self.transform(ctx)
          raw_data = ctx.raw_data

          BuildAccountSegment::Constants::FRESH_CASH_ADVANCE_TAG +
            FormatStrings::F2TS % raw_data[:fresh_cash_advance].size +
            raw_data[:fresh_cash_advance]
        end
      end
    end
  end
end
