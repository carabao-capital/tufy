module Tufy
  module Fields
    module Account
      class BuildNumberOfDaysPastDueField < BuildField
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

          BuildAccountSegment::Constants::NUMBER_OF_DAYS_PAST_DUE_TAG +
            FormatStrings::F2TS % (FormatStrings::F3TS % raw_data[:number_of_days_past_due]).size +
            FormatStrings::F3TS % raw_data[:number_of_days_past_due]
        end
      end
    end
  end
end
