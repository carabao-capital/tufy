module Tufy
  module Fields
    module Account
      class BuildOpenedDateField < BuildField
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

          BuildAccountSegment::Constants::OPENED_DATE_TAG +
            FormatStrings::F2TS % transform_date(raw_data[:opened_date]).size +
            transform_date(raw_data[:opened_date])
        end
      end
    end
  end
end
