module Tufy
  module Fields
    module Name
      class BuildDateOfBirthField < BuildField
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

          BuildNameSegment::Constants::DATE_OF_BIRTH_TAG +
            FormatStrings::F2TS % transform_date(raw_data[:date_of_birth]).size +
              transform_date(raw_data[:date_of_birth])
        end
      end
    end
  end
end
