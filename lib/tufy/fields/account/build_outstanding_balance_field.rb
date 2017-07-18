module Tufy
  module Fields
    module Account
      class BuildOutstandingBalanceField < BuildField
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

          outstanding_balance = raw_data[:outstanding_balance].to_i
          outstanding_balance = outstanding_balance < 0 ? 0 : outstanding_balance

          BuildAccountSegment::Constants::OUTSTANDING_BALANCE_TAG +
            FormatStrings::F2TS % outstanding_balance.to_s.size +
              outstanding_balance.to_s
        end
      end
    end
  end
end
