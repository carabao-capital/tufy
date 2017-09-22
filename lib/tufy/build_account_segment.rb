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
      :credit_limit_or_loan_amount,
      :shared_by,
      :outstanding_balance,
      :interest_and_fees,
      :number_of_days_past_due,
      :past_due_amount,
      :installment_amount,
      :number_of_installments,
      :payment_frequency,
      :expiry_date,
      :consumer_or_commercial,
      :legal_action,
    ]

    executed do |ctx|
      validate_presence_of_required_keys(ctx.raw_data, REQUIRED_KEYS)
      ctx.transformed_data = transform(ctx).upcase
    end

    def self.past_due_code(days_past_due)
      case days_past_due
      when 0
        0
      when (1..30)
        1
      else
        ((days_past_due - 1) / 30) * 30
      end
    end

    private

    def self.transform(ctx)
      ctx[:segment_tag] = Constants::SEGMENT_TAG

      result = with(ctx).reduce(
        Fields::BuildSegmentTagField,
        Fields::Account::BuildAccountNumberField,
        Fields::Account::BuildRestructuredAccountNumberField,
        Fields::Account::BuildUserIdField,
        Fields::Account::BuildAccountStatusField,
        Fields::Account::BuildAccountTypeField,
        Fields::Account::BuildCurrencyCodeField,
        Fields::Account::BuildOpenedDateField,
        Fields::Account::BuildPaymentAmountField,
        Fields::Account::BuildClosedDateField,
        Fields::Account::BuildReportedDateField,
        Fields::Account::BuildCreditLimitOrLoanAmountField,
        Fields::Account::BuildSharedByField,
        Fields::Account::BuildOutstandingBalanceField,
        Fields::Account::BuildInterestAndFeesField,
        Fields::Account::BuildUnbilledBalanceField,
        Fields::Account::BuildCashAdvanceBalanceField,
        Fields::Account::BuildNumberOfDaysPastDueField,
        Fields::Account::BuildPastDueAmountField,
        Fields::Account::BuildInstallmentAmountField,
        Fields::Account::BuildNumberOfInstallmentsField,
        Fields::Account::BuildPaymentFrequencyField,
        Fields::Account::BuildExpiryDateField,
        Fields::Account::BuildConsumerOrCommercialField,
        Fields::Account::BuildLegalActionField,
        Fields::Account::BuildPartialPaymentField,
        Fields::Account::BuildFreshCashAdvanceField,
      )

      result[:transformed_data]
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
      RESTRUCTURED = "C"
      BLOCKED_DUE_TO_CREDIT = "BC"
      VOLUNTARY_CLOSED = "CV"
      WRITE_OFF = "W"

      # account type constants
      SECURED_PERSONAL_LOAN = "3100"
      UNSECURED_PERSONAL_LOAN = "3000"

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
    end
  end
end
