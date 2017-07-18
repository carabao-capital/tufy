module Tufy
  module Fields
    module Account
      class BuildRestructuredAccountNumberField < BuildField
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

          BuildAccountSegment::Constants::RESTRUCTURED_ACCOUNT_NUMBER_TAG +
            FormatStrings::F2TS % (FormatStrings::F20TS % raw_data[:restructured_account_number]).to_s.size +
              FormatStrings::F20TS % raw_data[:restructured_account_number].to_s
        end
      end
    end
  end
end
