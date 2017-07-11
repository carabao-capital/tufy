module Tufy
  module Fields
    module Account
      class BuildAccountStatusField < BuildField
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

          BuildAccountSegment::Constants::ACCOUNT_STATUS_TAG +
            FormatStrings::F2TS % raw_data[:account_status].size +
            raw_data[:account_status]
        end
      end
    end
  end
end
