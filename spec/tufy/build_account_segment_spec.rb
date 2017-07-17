require "spec_helper"

module Tufy
  describe BuildAccountSegment, ".execute" do
    let(:raw_data) do
      {
        account_number: account_number,
        restructured_account_number: restructured_account_number,
        user_id: user_id,
        account_status: account_status,
        account_type: account_type,
        currency_code: currency_code,
        opened_date: opened_date,
        payment_amount: payment_amount,
        closed_date: closed_date,
        credit_limit_or_loan_amount: credit_limit_or_loan_amount,
        shared_by: shared_by,
        outstanding_balance: outstanding_balance,
        interest_and_fees: interest_and_fees,
        unbilled_balance: unbilled_balance,
        cash_advance_balance: cash_advance_balance,
        number_of_days_past_due: number_of_days_past_due,
        past_due_amount: past_due_amount,
        installment_amount: installment_amount,
        number_of_installments: number_of_installments,
        payment_frequency: payment_frequency,
        expiry_date: expiry_date,
        consumer_or_commercial: consumer_or_commercial,
        legal_action: legal_action,
        partial_payment: partial_payment,
        fresh_cash_advance: fresh_cash_advance,
      }
    end

    let(:account_number) { "00000000000000000001" }
    let(:restructured_account_number) { "00000000000000000001" }
    let(:user_id) { "BB030" }
    let(:account_status) { BuildAccountSegment::Constants::ACTIVE_OR_OPEN }
    let(:account_type) { BuildAccountSegment::Constants::SECURED_PERSONAL_LOAN }
    let(:currency_code) { BuildAccountSegment::Constants::PHP }
    let(:opened_date) { DateTime.now - 28 }
    let(:payment_amount) { 200000 }
    let(:closed_date) { DateTime.now + 14 }
    let(:reported_date) { DateTime.now }
    let(:credit_limit_or_loan_amount) { 400000 }
    let(:shared_by) { BuildAccountSegment::Constants::SHARED_BY_1 }
    let(:outstanding_balance) { 200000 }
    let(:interest_and_fees) { 10000 }
    let(:unbilled_balance) { 0 }
    let(:cash_advance_balance) { 0 }
    let(:number_of_days_past_due) { 0 }
    let(:past_due_amount) { 0 }
    let(:installment_amount) { 100000 }
    let(:number_of_installments) { 4 }
    let(:payment_frequency) { BuildAccountSegment::Constants::WEEKLY }
    let(:expiry_date) { DateTime.now + 14 }
    let(:consumer_or_commercial) { BuildAccountSegment::Constants::COMMERCIAL }
    let(:legal_action) { BuildAccountSegment::Constants::YES }
    let(:partial_payment) { BuildAccountSegment::Constants::NO }
    let(:fresh_cash_advance) { BuildAccountSegment::Constants::NO }

    let(:ctx) do
      {
        raw_data: raw_data,
        transformed_data: "",
      }
    end

    let(:expected_data) do
      BuildAccountSegment::Constants::SEGMENT_TAG +
        BuildAccountSegment::Constants::ACCOUNT_NUMBER_TAG +
        "#{FormatStrings::F2TS % account_number.size}#{account_number.upcase}" +
        BuildAccountSegment::Constants::RESTRUCTURED_ACCOUNT_NUMBER_TAG +
          "#{FormatStrings::F2TS % restructured_account_number.size}#{restructured_account_number.upcase}" +
        BuildAccountSegment::Constants::USER_ID_TAG +
          "#{FormatStrings::F2TS % user_id.size}#{user_id.upcase}" +
        BuildAccountSegment::Constants::ACCOUNT_STATUS_TAG +
          "#{FormatStrings::F2TS % account_status.size}#{account_status.upcase}" +
        BuildAccountSegment::Constants::ACCOUNT_TYPE_TAG +
          "#{FormatStrings::F2TS % account_type.size}#{account_type.upcase}" +
        BuildAccountSegment::Constants::CURRENCY_CODE_TAG +
          "#{FormatStrings::F2TS % currency_code.size}#{currency_code.upcase}" +
        BuildAccountSegment::Constants::OPENED_DATE_TAG +
          "#{FormatStrings::F2TS % opened_date.strftime("%d%m%Y").size}#{opened_date.strftime("%d%m%Y")}" +
        BuildAccountSegment::Constants::PAYMENT_AMOUNT_TAG +
          "#{FormatStrings::F2TS % payment_amount.to_i.to_s.size}#{payment_amount}" +
        BuildAccountSegment::Constants::CLOSED_DATE_TAG +
          "#{FormatStrings::F2TS % closed_date.strftime("%d%m%Y").size}#{closed_date.strftime("%d%m%Y")}" +
        BuildAccountSegment::Constants::REPORTED_DATE_TAG +
          "#{FormatStrings::F2TS % reported_date.strftime("%d%m%Y").size}#{reported_date.strftime("%d%m%Y")}" +
        BuildAccountSegment::Constants::CREDIT_LIMIT_OR_LOAN_AMOUNT_TAG +
          "#{FormatStrings::F2TS % credit_limit_or_loan_amount.to_i.to_s.size}#{credit_limit_or_loan_amount.to_i}" +
        BuildAccountSegment::Constants::SHARED_BY_TAG +
          "#{FormatStrings::F2TS % shared_by.size}#{shared_by}" +
        BuildAccountSegment::Constants::OUTSTANDING_BALANCE_TAG +
          "#{FormatStrings::F2TS % outstanding_balance.to_i.to_s.size}#{outstanding_balance.to_i}" +
        BuildAccountSegment::Constants::INTEREST_AND_FEES_TAG +
          "#{FormatStrings::F2TS % interest_and_fees.to_i.to_s.size}#{interest_and_fees.to_i}" +
        BuildAccountSegment::Constants::UNBILLED_BALANCE_TAG +
          "#{FormatStrings::F2TS % unbilled_balance.to_i.to_s.size}#{unbilled_balance.to_i}" +
        BuildAccountSegment::Constants::CASH_ADVANCE_BALANCE_TAG +
          "#{FormatStrings::F2TS % cash_advance_balance.to_i.to_s.size}#{cash_advance_balance.to_i}" +
        BuildAccountSegment::Constants::NUMBER_OF_DAYS_PAST_DUE_TAG +
          "#{FormatStrings::F2TS % (FormatStrings::F3TS % number_of_days_past_due).size}#{FormatStrings::F3TS % number_of_days_past_due}" +
        BuildAccountSegment::Constants::PAST_DUE_AMOUNT_TAG +
          "#{FormatStrings::F2TS % past_due_amount.to_i.to_s.size}#{past_due_amount.to_i}" +
        BuildAccountSegment::Constants::INSTALLMENT_AMOUNT_TAG +
          "#{FormatStrings::F2TS % installment_amount.to_i.to_s.size}#{installment_amount.to_i}" +
        BuildAccountSegment::Constants::NUMBER_OF_INSTALLMENTS_TAG +
        "#{FormatStrings::F2TS % number_of_installments.to_s.size}#{number_of_installments}" +
        BuildAccountSegment::Constants::PAYMENT_FREQUENCY_TAG +
          "#{FormatStrings::F2TS % payment_frequency.size}#{payment_frequency}" +
        BuildAccountSegment::Constants::EXPIRY_DATE_TAG +
          "#{FormatStrings::F2TS % expiry_date.strftime("%d%m%Y").size}#{expiry_date.strftime("%d%m%Y")}" +
        BuildAccountSegment::Constants::CONSUMER_OR_COMMERCIAL_TAG +
          "#{FormatStrings::F2TS % consumer_or_commercial.size}#{consumer_or_commercial}" +
        BuildAccountSegment::Constants::LEGAL_ACTION_TAG +
          "#{FormatStrings::F2TS % legal_action.size}#{legal_action}" +
        BuildAccountSegment::Constants::PARTIAL_PAYMENT_TAG +
          "#{FormatStrings::F2TS % partial_payment.size}#{partial_payment}" +
        BuildAccountSegment::Constants::FRESH_CASH_ADVANCE_TAG +
          "#{FormatStrings::F2TS % fresh_cash_advance.size}#{fresh_cash_advance}"
    end

    context "no error" do
      it "executes the action" do
        result = described_class.execute(ctx)
        expect(result[:transformed_data]).to eq expected_data
      end
    end

    context "with error" do
      BuildAccountSegment::REQUIRED_KEYS.each do |required_key|
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
