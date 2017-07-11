module Tufy
  module Fields
    module Account
      class BuildNumberOfInstallmentsField < BuildField
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

          BuildAccountSegment::Constants::NUMBER_OF_INSTALLMENTS_TAG +
            FormatStrings::F2TS % raw_data[:number_of_installments].to_i.to_s.size +
            raw_data[:number_of_installments].to_i.to_s
        end
      end
    end
  end
end
