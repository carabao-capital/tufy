module Tufy
  class BuildEndOfSubjectSegment < BuildSegment
    expects :raw_data
    promises :transformed_data

    executed do |ctx|
      ctx.transformed_data = ctx.transformed_data + transform(ctx).upcase
    end

    private

    def self.transform(ctx)
      raw_data = ctx[:raw_data]

      Constants::SEGMENT_TAG + # Segment Tag (Required)
        FormatStrings::F2TS % Constants::END_OF_SUBJECT.size +
          Constants::END_OF_SUBJECT
    end

    module Constants
      # tags
      SEGMENT_TAG = "ES"

      END_OF_SUBJECT = "**"
    end
  end
end
