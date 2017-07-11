module Tufy
  module Fields
    module Account
      class BuildCashAdvanceBalanceField < BuildField
        expects :raw_data
        promises :transformed_data

        executed do |ctx|
          if ctx.raw_data[:cash_advance_balance]
            ctx.transformed_data =
              ctx.transformed_data +
              transform(ctx).upcase
          end
        end

        private

        def self.transform(ctx)
          raw_data = ctx.raw_data

          BuildAccountSegment::Constants::CASH_ADVANCE_BALANCE_TAG +
            FormatStrings::F2TS % raw_data[:cash_advance_balance].to_i.to_s.size +
            raw_data[:cash_advance_balance].to_i.to_s
        end
      end
    end
  end
end
