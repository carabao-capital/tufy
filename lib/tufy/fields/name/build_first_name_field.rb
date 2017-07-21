module Tufy
  module Fields
    module Name
      class BuildFirstNameField < BuildField
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

          BuildNameSegment::Constants::FIRST_NAME_TAG +
            FormatStrings::F2TS % remove_special_characters_except_space(raw_data[:first_name]).size +
              remove_special_characters_except_space(raw_data[:first_name])
        end
      end
    end
  end
end
