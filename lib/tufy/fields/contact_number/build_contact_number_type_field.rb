module Tufy
  module Fields
    module ContactNumber
      class BuildContactNumberTypeField < BuildField
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

          BuildContactNumberSegment::Constants::CONTACT_NUMBER_TYPE_TAG +
            FormatStrings::F2TS % raw_data[:contact_number_type].size +
              raw_data[:contact_number_type]
        end
      end
    end
  end
end
