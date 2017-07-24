require "spec_helper"

module Tufy
  describe BuildHeaderSegment, ".execute" do
    let(:member_reference_number) { "A1234" }
    let(:processor_name) { "Company Name" }
    let(:user_id) { "BB030" }
    let(:reported_date) { Date.today }

    let(:header_data) do
      {
        member_reference_number: member_reference_number,
        processor_name: processor_name,
        user_id: user_id,
        reported_date: reported_date,
      }
    end

    let(:ctx) do
      {
        header_data: header_data,
        transformed_data: "",
      }
    end

    let(:expected_data) do
      BuildHeaderSegment::Constants::SEGMENT_TAG + # Segment Tag (Required)
        BuildHeaderSegment::Constants::TUDF_VERSION + # Version Tag (Required)
        "#{FormatStrings::F25TS % member_reference_number}" + # Member Reference Number (Required)
        "#{FormatStrings::F26TS % processor_name.upcase}" + # Member Processor Name (Required)
        "#{FormatStrings::F10TS % user_id}" + # User ID (Required)
        "#{reported_date.strftime("%d%m%Y")}" + # Reported Date (Required)
        BuildHeaderSegment::Constants::FILLER  # Filler (Required)
    end

    before :each do
      allow(Time).to receive_message_chain(:now, :to_i, :to_s).and_return(member_reference_number)
    end

    context "no error" do
      it "executes the action" do
        result = described_class.execute(ctx)
        expect(result[:transformed_data]).to eq expected_data
      end
    end

    context "with error" do
      BuildHeaderSegment::REQUIRED_KEYS.each do |required_key|
        before(:each) do
          header_data.delete(required_key)
        end

        it "executes the action" do
          expect { described_class.execute(ctx) }.to raise_error Tufy::Errors::RequiredDataMissing
        end
      end
    end
  end
end
