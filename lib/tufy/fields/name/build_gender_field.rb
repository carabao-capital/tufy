module Tufy
  module Fields
    module Name
      class BuildGenderField < BuildField
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

          BuildNameSegment::Constants::GENDER_TAG +
            FormatStrings::F2TS % raw_data[:gender].size +
              raw_data[:gender]
        end
      end
    end
  end
end
