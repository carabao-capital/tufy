require "spec_helper"

module Tufy
  describe TransformRawDataArray, ".execute" do
    let(:ctx) do
      {
        header_data: {},
        raw_data_array: [{}],
      }
    end


    it "executes the actions in order" do
      actions = [
        BuildHeaderSegment,
        BuildRecords,
      ]

      actions.each do |action|
        expect(action).to receive(:execute).with(ctx).
          once.and_return(ctx)
      end

      described_class.execute(ctx)
    end
  end
end
