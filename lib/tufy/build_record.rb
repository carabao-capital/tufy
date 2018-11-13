module Tufy
  class BuildRecord
    extend LightService::Organizer

    def self.execute(ctx)
      ctx[:transformed_data] = ''
      ctx = with(ctx).reduce(
        BuildNameSegment,
        BuildAddressSegment,
        BuildContactNumberSegment,
        BuildEmailAddressSegment,
        BuildAccountSegment,
        BuildEndOfSubjectSegment,
      )
      ctx[:transformed_data]
    end
  end
end

