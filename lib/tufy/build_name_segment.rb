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
      ctx.transformed_data = transform(ctx).upcase
    end

    private

    def self.transform(ctx)
      ctx[:segment_tag] = Constants::SEGMENT_TAG

      result = with(ctx).reduce(
        Fields::BuildSegmentTagField,
        Fields::Name::BuildFirstNameField,
        Fields::Name::BuildLastNameField,
        Fields::Name::BuildCivilStatusField,
        Fields::Name::BuildDateOfBirthField,
        Fields::Name::BuildGenderField,
        Fields::Name::BuildAcHolderTypeField,
      )

      result[:transformed_data]
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
