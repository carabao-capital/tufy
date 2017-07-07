require "spec_helper"

module Tufy
  describe BuildRecords, ".execute" do
    let(:ctx) do
      {
        header_data: {},
        raw_data_array: [
          {},
          {},
        ],
        transformed_data: "",
      }
    end


    it "executes the actions in order" do
      expect(BuildRecord).to receive(:execute).with(raw_data: {}).
        twice.and_return("")

      described_class.execute(ctx)
    end
  end
end

