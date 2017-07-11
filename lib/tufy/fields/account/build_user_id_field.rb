module Tufy
  module Fields
    module Account
      class BuildUserIdField < BuildField
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

          BuildAccountSegment::Constants::USER_ID_TAG +
            FormatStrings::F2TS % raw_data[:user_id].size +
            raw_data[:user_id]
        end
      end
    end
  end
end
