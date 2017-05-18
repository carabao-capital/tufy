module Tufy
  class BuildNameSegment < BuildSegment
    expects :raw_data
    promises :transformed_data

    REQUIRED_KEYS = [
      :first_name,
      :last_name,
      :civil_status,
      :date_of_birth,
      :gender,
      :ac_holder_type,
    ]

    executed do |ctx|
      validate_presence_of_required_keys(ctx.raw_data, REQUIRED_KEYS)
      ctx.transformed_data = ctx.transformed_data + transform(ctx).upcase
    end

    private

    def self.transform(ctx)
      raw_data = ctx[:raw_data]

      Constants::SEGMENT_TAG + # Segment Tag (Required)
        Constants::FIRST_NAME_TAG +
          FormatStrings::F2TS % raw_data[:first_name].size +
            raw_data[:first_name] + # First Name (Required)
        Constants::LAST_NAME_TAG +
          FormatStrings::F2TS % raw_data[:last_name].size +
            raw_data[:last_name] + # Last Name (Required)
        Constants::CIVIL_STATUS_TAG +
          FormatStrings::F2TS % raw_data[:civil_status].size +
            raw_data[:civil_status] + # Civil Status (Required)
        Constants::DATE_OF_BIRTH_TAG +
          FormatStrings::F2TS % transform_date(raw_data[:date_of_birth]).size +
            transform_date(raw_data[:date_of_birth]) + # Date of Birth (Required)
        Constants::GENDER_TAG +
          FormatStrings::F2TS % raw_data[:gender].size +
            raw_data[:gender] + # Gender (Required)
        Constants::AC_HOLDER_TYPE_TAG +
          FormatStrings::F2TS % raw_data[:ac_holder_type].size +
            raw_data[:ac_holder_type] # A/C Holder Type
    end

    module Constants
      # tags
      SEGMENT_TAG = "NA03N01"
      FIRST_NAME_TAG = "01"
      LAST_NAME_TAG = "03"
      CIVIL_STATUS_TAG = "05"
      DATE_OF_BIRTH_TAG = "06"
      GENDER_TAG = "07"
      AC_HOLDER_TYPE_TAG = "12"

      # civil status constants
      SINGLE = "S"
      MARRIED = "M"
      DIVORCED = "D"
      WIDOWED = "W"
      CIVIL_STATUS_UNKNOWN = "U"

      # gender constants
      FEMALE = "1"
      MALE = "2"
      GENDER_UNKNOWN = "3"

      # a/c holder type constants
      HI = "HI"
      HPI = "HPI"
      HJ = "HJ"
      G = "G"
    end
  end
end
