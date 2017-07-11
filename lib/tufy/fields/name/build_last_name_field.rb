module Tufy
  module Fields
    module Name
      class BuildLastNameField < BuildField
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

          BuildNameSegment::Constants::LAST_NAME_TAG +
            FormatStrings::F2TS % raw_data[:last_name].size +
              raw_data[:last_name]
        end
      end
    end
  end
end
