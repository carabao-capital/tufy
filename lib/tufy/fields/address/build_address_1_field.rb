module Tufy
  module Fields
    module Address
      class BuildAddress1Field < BuildField
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

          BuildAddressSegment::Constants::ADDRESS_LINE_1_TAG +
            FormatStrings::F2TS % remove_special_characters(raw_data[:address_line_1]).size +
              remove_special_characters(raw_data[:address_line_1])
        end
      end
    end
  end
end
