module Tufy
  class Transform
    include LightService::Organizer
    include LightService::Action

    expects :raw_data

    executed do |ctx|
      ctx[:transformed_data] = ""

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
