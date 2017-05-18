require "spec_helper"

module Tufy
  describe BuildNameSegment, ".execute" do
    let(:raw_data) do
      {
        first_name: first_name,
        last_name: last_name,
        civil_status: civil_status,
        date_of_birth: date_of_birth,
        gender: gender,
        ac_holder_type: ac_holder_type,
      }
    end

    let(:first_name) { "First Name" }
    let(:last_name) { "Last Name" }
    let(:civil_status) { BuildNameSegment::Constants::SINGLE }
    let(:date_of_birth) { Date.today }
    let(:gender) { BuildNameSegment::Constants::MALE }
    let(:ac_holder_type) { BuildNameSegment::Constants::HI }

    let(:ctx) do
      {
        raw_data: raw_data,
        transformed_data: "",
      }
    end

    let(:expected_data) do
      BuildNameSegment::Constants::SEGMENT_TAG +
        BuildNameSegment::Constants::FIRST_NAME_TAG +
          "#{FormatStrings::F2TS % first_name.size}#{first_name.upcase}" +
        BuildNameSegment::Constants::LAST_NAME_TAG +
          "#{FormatStrings::F2TS % last_name.size}#{last_name.upcase}" +
        BuildNameSegment::Constants::CIVIL_STATUS_TAG +
          "#{FormatStrings::F2TS % civil_status.size}#{civil_status.upcase}" +
        BuildNameSegment::Constants::DATE_OF_BIRTH_TAG +
          "#{FormatStrings::F2TS % date_of_birth.strftime("%d%m%Y").size}" + "#{date_of_birth.strftime("%d%m%Y")}" +
        BuildNameSegment::Constants::GENDER_TAG +
          "#{FormatStrings::F2TS % gender.size}#{gender}" +
        BuildNameSegment::Constants::AC_HOLDER_TYPE_TAG +
          "#{FormatStrings::F2TS % ac_holder_type.size}#{ac_holder_type}"
    end

    context "no error" do
      it "executes the action" do
        result = described_class.execute(ctx)
        expect(result[:transformed_data]).to eq expected_data
      end
    end

    context "with error" do
      BuildNameSegment::REQUIRED_KEYS.each do |required_key|
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
