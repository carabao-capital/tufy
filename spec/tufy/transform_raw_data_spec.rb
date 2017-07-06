require "spec_helper"

module Tufy
  describe TransformRawData, ".execute" do
    let(:ctx) do
      {
        raw_data: {},
      }
    end


    it "executes the actions in order" do
      actions = [
        BuildNameSegment,
        BuildAddressSegment,
        BuildContactNumberSegment,
        BuildEmailAddressSegment,
        BuildAccountSegment,
        BuildEndOfSubjectSegment,
      ]

      actions.each do |action|
        expect(action).to receive(:execute).with(ctx).
          once.and_return(ctx)
      end

      described_class.execute(ctx)
    end
  end
end
