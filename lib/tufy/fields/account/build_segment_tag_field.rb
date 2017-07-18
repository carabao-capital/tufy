module Tufy
  module Fields
    class BuildSegmentTagField < BuildField
      expects :segment_tag
      promises :transformed_data

      executed do |ctx|
        ctx.transformed_data =
          ctx.transformed_data +
          ctx.segment_tag
      end
    end
  end
end
