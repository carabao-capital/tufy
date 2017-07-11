module Tufy
  module Fields
    module Account
      class BuildSharedByField < BuildField
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

          BuildAccountSegment::Constants::SHARED_BY_TAG +
            FormatStrings::F2TS % raw_data[:shared_by].size +
            raw_data[:shared_by]
        end
      end
    end
  end
end
