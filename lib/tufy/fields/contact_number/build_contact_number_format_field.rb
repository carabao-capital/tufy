module Tufy
  module Fields
    module ContactNumber
      class BuildContactNumberFormatField < BuildField
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

          BuildContactNumberSegment::Constants::CONTACT_NUMBER_FORMAT_TAG +
            FormatStrings::F2TS % raw_data[:contact_number_format].size +
              raw_data[:contact_number_format]
        end
      end
    end
  end
end
