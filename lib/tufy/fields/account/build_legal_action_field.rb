module Tufy
  module Fields
    module Account
      class BuildLegalActionField < BuildField
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

          BuildAccountSegment::Constants::LEGAL_ACTION_TAG +
            FormatStrings::F2TS % raw_data[:legal_action].size +
            raw_data[:legal_action]
        end
      end
    end
  end
end
