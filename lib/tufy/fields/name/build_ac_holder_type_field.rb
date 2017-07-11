module Tufy
  module Fields
    module Name
      class BuildAcHolderTypeField < BuildField
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

          BuildNameSegment::Constants::AC_HOLDER_TYPE_TAG +
            FormatStrings::F2TS % raw_data[:ac_holder_type].size +
              raw_data[:ac_holder_type]
        end
      end
    end
  end
end
