require "spec_helper"

module Tufy
  describe BuildEmailAddressSegment, ".execute" do
    let(:raw_data) do
      {
        email_address: email_address,
      }
    end

    let(:email_address) { "address@email.com" }

    let(:ctx) do
      {
        raw_data: raw_data,
        transformed_data: "",
      }
    end

    let(:expected_data) do
      BuildEmailAddressSegment::Constants::SEGMENT_TAG +
        BuildEmailAddressSegment::Constants::EMAIL_ADDRESS_TAG +
        "#{FormatStrings::F2TS % email_address.size}#{email_address.upcase}"
    end

    context "no error" do
      it "executes the action" do
        result = described_class.execute(ctx)
        expect(result[:transformed_data]).to eq expected_data
      end
    end

    context "with error" do
      BuildEmailAddressSegment::REQUIRED_KEYS.each do |required_key|
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
