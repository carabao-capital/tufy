module Tufy
  class BuildIdSegment < BuildSegment
    expects :raw_data
    promises :transformed_data

    REQUIRED_KEYS = [
      :id_number,
      :id_type,
    ]

    executed do |ctx|
      # ID Segment is not required.
      # If ID type passed here does
      # not exist, do not proceed.
      # TODO: Testing
      validate_presence_of_required_keys(ctx.raw_data, REQUIRED_KEYS)
      if id_type_exists?(ctx.raw_data[:id_type])
        ctx.transformed_data = ctx.transformed_data + transform(ctx).upcase
      end
    end

    private

    def self.transform(ctx)
      raw_data = ctx[:raw_data]

      result = with(ctx).reduce(
        Fields::Id::BuildIdNumberField,
        Fields::Id::BuildIdTypeField,
      )

      Constants::SEGMENT_TAG + result[:transformed_data]
    end

    def self.id_type_exists?(id_type)
      Constants::ID_TYPES.include?(id_type)
    end

    module Constants
      # tags
      SEGMENT_TAG = "ID03I01"
      ID_NUMBER_TAG = "01"
      ID_TYPE_TAG = "02"

      # id type constants
      SSS = "SSS"
      PP = "PP"
      TIN = "TIN"
      DL = "DL"
      GSIS = "GSIS"
      UMID = "UMID"

      ID_TYPES = [SSS, PP, TIN, DL, GSIS, UMID]
    end
  end
end
