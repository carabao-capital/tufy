module Tufy
  module Fields
    module ContactNumber
      class BuildContactNumberField < BuildField
        # When raw_data[:contact_number].blank?
        # we use NULL_CONTACT_NUMBER instead
        NULL_CONTACT_NUMBER = "0000000000"

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

          contact_number = if raw_data[:contact_number].empty?
                             NULL_CONTACT_NUMBER
                           else
                            raw_data[:contact_number]
                           end

          BuildContactNumberSegment::Constants::CONTACT_NUMBER_TAG +
            FormatStrings::F2TS % remove_special_characters(contact_number).size +
              remove_special_characters(contact_number)
        end
      end
    end
  end
end
