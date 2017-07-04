module Tufy
  class BuildAccountSegment < BuildSegment
    expects :raw_data
    promises :transformed_data

    REQUIRED_KEYS = [
      :account_number,
      :restructured_account_number,
      :user_id,
      :account_status,
      :account_type,
      :currency_code,
      :opened_date,
      :payment_amount,
      :closed_date,
      :credit_limit_or_loan_amount,
      :shared_by,
      :outstanding_balance,
      :interest_and_fees,
      :unbilled_balance,
      :cash_advance_balance,
      :number_of_days_past_due,
      :past_due_amount,
      :installment_amount,
      :number_of_installments,
      :payment_frequency,
      :expiry_date,
      :consumer_or_commercial,
      :legal_action,
      :partial_payment,
      :fresh_cash_advance,
    ]

    executed do |ctx|
      validate_presence_of_required_keys(ctx.raw_data, REQUIRED_KEYS)
      ctx.transformed_data = ctx.transformed_data + transform(ctx).upcase
    end

    private

    def self.transform(ctx)
      raw_data = ctx[:raw_data]

      Constants::SEGMENT_TAG +
        Constants::ACCOUNT_NUMBER_TAG +
        FormatStrings::F2TS % raw_data[:account_number].to_s.size + raw_data[:account_number].to_s +
        Constants::RESTRUCTURED_ACCOUNT_NUMBER_TAG +
          FormatStrings::F2TS % raw_data[:restructured_account_number].to_s.size + raw_data[:restructured_account_number].to_s +
        Constants::USER_ID_TAG +
          FormatStrings::F2TS % raw_data[:user_id].size + raw_data[:user_id] +
        Constants::ACCOUNT_STATUS_TAG +
          FormatStrings::F2TS % raw_data[:account_status].size + raw_data[:account_status] +
        Constants::ACCOUNT_TYPE_TAG +
          FormatStrings::F2TS % raw_data[:account_type].size + raw_data[:account_type] +
        Constants::CURRENCY_CODE_TAG +
          FormatStrings::F2TS % raw_data[:currency_code].size + raw_data[:currency_code] +
        Constants::OPENED_DATE_TAG +
          FormatStrings::F2TS % transform_date(raw_data[:opened_date]).size + transform_date(raw_data[:opened_date]) +
        Constants::PAYMENT_AMOUNT_TAG +
          FormatStrings::F2TS % raw_data[:payment_amount].to_i.to_s.size + raw_data[:payment_amount].to_i.to_s +
        Constants::CLOSED_DATE_TAG +
          FormatStrings::F2TS % transform_date(raw_data[:closed_date]).size + transform_date(raw_data[:closed_date]) +
        Constants::REPORTED_DATE_TAG +
          FormatStrings::F2TS % transform_date(DateTime.now).size + transform_date(DateTime.now) +
        Constants::CREDIT_LIMIT_OR_LOAN_AMOUNT_TAG +
          FormatStrings::F2TS % raw_data[:credit_limit_or_loan_amount].to_i.to_s.size + raw_data[:credit_limit_or_loan_amount].to_i.to_s +
        Constants::SHARED_BY_TAG +
          FormatStrings::F2TS % raw_data[:shared_by].size + raw_data[:shared_by] +
        Constants::OUTSTANDING_BALANCE_TAG +
          FormatStrings::F2TS % raw_data[:outstanding_balance].to_i.to_s.size + raw_data[:outstanding_balance].to_i.to_s +
        Constants::INTEREST_AND_FEES_TAG +
          FormatStrings::F2TS % raw_data[:interest_and_fees].to_i.to_s.size + raw_data[:interest_and_fees].to_i.to_s +
        Constants::UNBILLED_BALANCE_TAG +
          FormatStrings::F2TS % raw_data[:unbilled_balance].to_i.to_s.size + raw_data[:unbilled_balance].to_i.to_s +
        Constants::CASH_ADVANCE_BALANCE_TAG +
          FormatStrings::F2TS % raw_data[:cash_advance_balance].to_i.to_s.size + raw_data[:cash_advance_balance].to_i.to_s +
        Constants::NUMBER_OF_DAYS_PAST_DUE_TAG +
          FormatStrings::F2TS % (FormatStrings::F3TS % raw_data[:number_of_days_past_due]).size + FormatStrings::F3TS % raw_data[:number_of_days_past_due] +
        Constants::PAST_DUE_AMOUNT_TAG +
          FormatStrings::F2TS % raw_data[:past_due_amount].to_i.to_s.size + raw_data[:past_due_amount].to_i.to_s +
        Constants::INSTALLMENT_AMOUNT_TAG +
          FormatStrings::F2TS % raw_data[:installment_amount].to_i.to_s.size + raw_data[:installment_amount].to_i.to_s +
        Constants::NUMBER_OF_INSTALLMENTS_TAG +
          FormatStrings::F2TS % raw_data[:number_of_installments].to_i.to_s.size + raw_data[:number_of_installments].to_i.to_s +
        Constants::PAYMENT_FREQUENCY_TAG +
          FormatStrings::F2TS % raw_data[:payment_frequency].size + raw_data[:payment_frequency] +
        Constants::EXPIRY_DATE_TAG +
          FormatStrings::F2TS % transform_date(raw_data[:expiry_date]).size + transform_date(raw_data[:expiry_date]) +
        Constants::CONSUMER_OR_COMMERCIAL_TAG +
          FormatStrings::F2TS % raw_data[:consumer_or_commercial].size + raw_data[:consumer_or_commercial] +
        Constants::LEGAL_ACTION_TAG +
          FormatStrings::F2TS % raw_data[:legal_action].size + raw_data[:legal_action] +
        Constants::PARTIAL_PAYMENT_TAG +
          FormatStrings::F2TS % raw_data[:partial_payment].size + raw_data[:partial_payment] +
        Constants::FRESH_CASH_ADVANCE_TAG +
          FormatStrings::F2TS % raw_data[:fresh_cash_advance].size + raw_data[:fresh_cash_advance]
    end

    module Constants
      # tags
      SEGMENT_TAG = "AC04A001"
      ACCOUNT_NUMBER_TAG = "01"
      RESTRUCTURED_ACCOUNT_NUMBER_TAG = "02"
      USER_ID_TAG = "03"
      ACCOUNT_STATUS_TAG = "04"
      ACCOUNT_TYPE_TAG = "05"
      CURRENCY_CODE_TAG = "06"
      OPENED_DATE_TAG = "07"
      PAYMENT_AMOUNT_TAG = "08"
      CLOSED_DATE_TAG = "09"
      REPORTED_DATE_TAG = "10"
      CREDIT_LIMIT_OR_LOAN_AMOUNT_TAG = "11"
      SHARED_BY_TAG = "12"
      OUTSTANDING_BALANCE_TAG = "13"
      INTEREST_AND_FEES_TAG = "14"
      UNBILLED_BALANCE_TAG = "15"
      CASH_ADVANCE_BALANCE_TAG = "16"
      NUMBER_OF_DAYS_PAST_DUE_TAG = "17"
      PAST_DUE_AMOUNT_TAG = "18"
      INSTALLMENT_AMOUNT_TAG = "19"
      NUMBER_OF_INSTALLMENTS_TAG = "20"
      PAYMENT_FREQUENCY_TAG = "21"
      EXPIRY_DATE_TAG = "22"
      CONSUMER_OR_COMMERCIAL_TAG = "23"
      LEGAL_ACTION_TAG = "24"
      PARTIAL_PAYMENT_TAG = "25"
      FRESH_CASH_ADVANCE_TAG = "26"

      # account status constants
      ACTIVE_OR_OPEN = "A"

      # account type constants
      SECURED_PERSONAL_LOAN = "3100"

      # currency code constants
      PHP = "PHP"

      # shared by constants
      SHARED_BY_1 = "1"

      # payment frequency constants
      ANNUAL = "A"
      BI_WEEKLY = "B"
      MONTHLY = "M"
      QUARTERLY = "Q"
      SEMI_ANNUALLY = "S"
      WEEKLY = "W"

      # consumer or commercial constants
      CONSUMER = "I"
      COMMERCIAL = "C"

      # legal action, partial payment,
      # fresh cash advance constants
      YES = "Y"
      NO = "N"
      NOT_APPLICABLE = "A"

      # TU Code for Number of Days Past Due
      PAST_DUE_CODE_000 = '000'
      PAST_DUE_CODE_001 = '001'
      PAST_DUE_CODE_030 = '030'
      PAST_DUE_CODE_060 = '060'
      PAST_DUE_CODE_090 = '090'
      PAST_DUE_CODE_120 = '120'
      PAST_DUE_CODE_150 = '150'
    end
  end
end
