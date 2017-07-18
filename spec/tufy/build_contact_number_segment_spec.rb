require "spec_helper"

module Tufy
  describe BuildContactNumberSegment, ".execute" do
    let(:raw_data) do
      {
        contact_number: contact_number,
        contact_number_format: contact_number_format,
        contact_number_type: contact_number_type,
      }
    end

    let(:contact_number) { "+639987903951" }
    let(:contact_number_format) { BuildContactNumberSegment::Constants::FREE_FORMAT }
    let(:contact_number_type) { BuildContactNumberSegment::Constants::UNKNOWN }

    let(:ctx) do
      {
        raw_data: raw_data,
        transformed_data: "",
      }
    end

    let(:expected_data) do
      BuildContactNumberSegment::Constants::SEGMENT_TAG +
        BuildContactNumberSegment::Constants::CONTACT_NUMBER_TAG +
        "#{FormatStrings::F2TS % contact_number.gsub(/[^0-9A-Za-z]/, '').size}#{contact_number.gsub(/[^0-9A-Za-z]/, '')}" +
        BuildContactNumberSegment::Constants::CONTACT_NUMBER_FORMAT_TAG +
          "#{FormatStrings::F2TS % contact_number_format.size}#{contact_number_format.upcase}" +
        BuildContactNumberSegment::Constants::CONTACT_NUMBER_TYPE_TAG +
          "#{FormatStrings::F2TS % contact_number_type.size}#{contact_number_type.upcase}"
    end

    context "no error" do
      it "executes the action" do
        result = described_class.execute(ctx)
        expect(result[:transformed_data]).to eq expected_data
      end
    end

    context "with error" do
      BuildContactNumberSegment::REQUIRED_KEYS.each do |required_key|
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
