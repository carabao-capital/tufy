require "spec_helper"

module Tufy
  describe BuildAddressSegment, ".execute" do
    let(:raw_data) do
      {
        address_line_1: address_line_1,
        address_line_2: address_line_2,
        address_type: address_type,
      }
    end

    let(:address_line_1) { "Somesome Street, Somesome Village" }
    let(:address_line_2) { "Somesome Barangay, Somesome City" }
    let(:address_type) { BuildAddressSegment::Constants::RESIDENTIAL }

    let(:ctx) do
      {
        raw_data: raw_data,
        transformed_data: "",
      }
    end

    let(:expected_data) do
      BuildAddressSegment::Constants::SEGMENT_TAG +
        BuildAddressSegment::Constants::ADDRESS_LINE_1_TAG +
        "#{FormatStrings::F2TS % address_line_1.gsub(/[^0-9A-Za-z]/, '').size}" +
          "#{address_line_1.gsub(/[^0-9A-Za-z]/, '').upcase}" +
        BuildAddressSegment::Constants::ADDRESS_LINE_2_TAG +
          "#{FormatStrings::F2TS % address_line_2.gsub(/[^0-9A-Za-z]/, '').size}" +
            "#{address_line_2.gsub(/[^0-9A-Za-z]/, '').upcase}" +
        BuildAddressSegment::Constants::ADDRESS_TYPE_TAG +
          "#{FormatStrings::F2TS % address_type.size}#{address_type.upcase}"
    end

    context "no error" do
      it "executes the action" do
        result = described_class.execute(ctx)
        expect(result[:transformed_data]).to eq expected_data
      end
    end

    context "with error" do
      BuildAddressSegment::REQUIRED_KEYS.each do |required_key|
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
