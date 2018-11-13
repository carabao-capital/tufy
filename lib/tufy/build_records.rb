module Tufy
  class BuildRecords
    extend LightService::Action

    expects :raw_data_array, :transformed_data
    promises :transformed_data

    executed do |ctx|
      ctx.transformed_data = ctx.transformed_data + transform(ctx).upcase
    end

    private

    def self.transform(ctx)
      raw_data_array = ctx[:raw_data_array]
      raw_data_array.inject("") do |data, raw_data|
        data = data + BuildRecord.execute(raw_data: raw_data)
      end
    end
  end
end

