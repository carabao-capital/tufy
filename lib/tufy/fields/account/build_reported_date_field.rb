module Tufy
  module Fields
    module Account
      class BuildReportedDateField < BuildField
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

          BuildAccountSegment::Constants::REPORTED_DATE_TAG +
            FormatStrings::F2TS % transform_date(DateTime.now).size +
            transform_date(DateTime.now)
        end
      end
    end
  end
end
