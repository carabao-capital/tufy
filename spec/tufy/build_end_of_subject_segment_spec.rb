require "spec_helper"

module Tufy
  describe BuildEndOfSubjectSegment, ".execute" do
    let(:raw_data) do
      {}
    end

    let(:ctx) do
      {
        raw_data: raw_data,
        transformed_data: "",
      }
    end

    let(:expected_data) do
      BuildEndOfSubjectSegment::Constants::SEGMENT_TAG +
        "#{FormatStrings::F2TS % BuildEndOfSubjectSegment::Constants::END_OF_SUBJECT.size}#{BuildEndOfSubjectSegment::Constants::END_OF_SUBJECT}"
    end

    context "no error" do
      it "executes the action" do
        result = described_class.execute(ctx)
        expect(result[:transformed_data]).to eq expected_data
      end
    end
  end
end
