module Tufy
  module Fields
    module Address
      class BuildAddress2Field < BuildField
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

          BuildAddressSegment::Constants::ADDRESS_LINE_2_TAG +
            FormatStrings::F2TS % remove_special_characters_except_space(raw_data[:address_line_2]).size +
              remove_special_characters_except_space(raw_data[:address_line_2])
        end
      end
    end
  end
end
