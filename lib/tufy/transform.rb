module Tufy
  class Transform
    include LightService::Organizer

    def self.execute(ctx)
      with(ctx).reduce(
        BuildHeaderSegment,
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
