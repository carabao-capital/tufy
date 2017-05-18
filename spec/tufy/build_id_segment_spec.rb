require "spec_helper"

module Tufy
  describe BuildIdSegment, ".execute" do
    let(:raw_data) do
      {
        id_number: id_number,
        id_type: id_type,
      }
    end

    let(:id_number) { "123-456-789" }
    let(:id_type) { BuildIdSegment::Constants::SSS }

    let(:ctx) do
      {
        raw_data: raw_data,
        transformed_data: "",
      }
    end

    let(:expected_data) do
      BuildIdSegment::Constants::SEGMENT_TAG +
        BuildIdSegment::Constants::ID_NUMBER_TAG +
        "#{FormatStrings::F2TS % id_number.gsub(/[^0-9A-Za-z]/, '').size}#{id_number.gsub(/[^0-9A-Za-z]/, '').upcase}" +
        BuildIdSegment::Constants::ID_TYPE_TAG +
          "#{FormatStrings::F2TS % id_type.size}#{id_type.upcase}"
    end

    context "no error" do
      it "executes the action" do
        result = described_class.execute(ctx)
        expect(result[:transformed_data]).to eq expected_data
      end
    end

    context "with error" do
      BuildIdSegment::REQUIRED_KEYS.each do |required_key|
        before(:each) do
          raw_data.delete(required_key)
        end

        it "executes the action" do
          expect { described_class.execute(ctx) }.to raise_error Tufy::Errors::RequiredDataMissing
        end
      end
    end
  end
end
