module Tufy
  module Fields
    module ContactNumber
      class BuildContactNumberField < BuildField
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

          BuildContactNumberSegment::Constants::CONTACT_NUMBER_TAG +
            FormatStrings::F2TS % remove_special_characters(raw_data[:contact_number]).size +
              remove_special_characters(raw_data[:contact_number])
        end
      end
    end
  end
end
