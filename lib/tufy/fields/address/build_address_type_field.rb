module Tufy
  module Fields
    module Address
      class BuildAddressTypeField < BuildField
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

          BuildAddressSegment::Constants::ADDRESS_TYPE_TAG +
            FormatStrings::F2TS % raw_data[:address_type].size +
              raw_data[:address_type]
        end
      end
    end
  end
end
