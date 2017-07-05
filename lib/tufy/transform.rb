module Tufy
  class Transform
    include LightService::Organizer

    def self.execute(ctx)
      ctx[:transformed_data] = ''
      with(ctx).reduce(
        BuildHeaderSegment,
        BuildNameSegment,
        BuildAddressSegment,
        BuildContactNumberSegment,
        BuildEmailAddressSegment,
        BuildAccountSegment,
        BuildEndOfSubjectSegment,
      )
    end
  end
end
