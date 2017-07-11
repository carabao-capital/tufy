module Tufy
  module Fields
    module Account
      class BuildCurrencyCodeField < BuildField
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

          BuildAccountSegment::Constants::CURRENCY_CODE_TAG +
            FormatStrings::F2TS % raw_data[:currency_code].size + raw_data[:currency_code]
        end
      end
    end
  end
end
