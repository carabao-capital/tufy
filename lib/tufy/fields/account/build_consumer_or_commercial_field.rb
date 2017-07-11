module Tufy
  module Fields
    module Account
      class BuildConsumerOrCommercialField < BuildField
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

          BuildAccountSegment::Constants::CONSUMER_OR_COMMERCIAL_TAG +
            FormatStrings::F2TS % raw_data[:consumer_or_commercial].size +
            raw_data[:consumer_or_commercial]
        end
      end
    end
  end
end
