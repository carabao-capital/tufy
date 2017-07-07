module Tufy
  class TransformRawDataArray
    include LightService::Organizer

    def self.execute(ctx)
      ctx[:transformed_data] = ''
      ctx = with(ctx).reduce(
        BuildHeaderSegment,
        BuildRecords,
      )
      ctx[:transformed_data]
    end
  end
end
