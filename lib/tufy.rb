require "tufy/version"
require "light-service"
require "date"
require "tufy/format_strings"
require "tufy/errors/required_data_missing_error"
require "tufy/build_segment"
require "tufy/build_header_segment"
require "tufy/build_name_segment"
require "tufy/build_id_segment"
require "tufy/build_address_segment"
require "tufy/build_contact_number_segment"
require "tufy/build_email_address_segment"
require "tufy/build_account_segment"
require "tufy/build_end_of_subject_segment"
require "tufy/build_records"
require "tufy/build_record"
require "tufy/transform_raw_data"
require "tufy/transform_raw_data_array"
require "tufy/build_field.rb"
require "tufy/fields/account/build_account_number_field.rb"
require "tufy/fields/account/build_account_status_field.rb"
require "tufy/fields/account/build_account_type_field.rb"
require "tufy/fields/account/build_cash_advance_balance_field.rb"
require "tufy/fields/account/build_closed_date_field.rb"
require "tufy/fields/account/build_consumer_or_commercial_field.rb"
require "tufy/fields/account/build_credit_limit_or_loan_amount_field.rb"
require "tufy/fields/account/build_currency_code_field.rb"
require "tufy/fields/account/build_expiry_date_field.rb"
require "tufy/fields/account/build_fresh_cash_advance_field.rb"
require "tufy/fields/account/build_interest_and_fees_field.rb"
require "tufy/fields/account/build_installment_amount_field.rb"
require "tufy/fields/account/build_legal_action_field.rb"
require "tufy/fields/account/build_number_of_days_past_due_field.rb"
require "tufy/fields/account/build_number_of_installments_field.rb"
require "tufy/fields/account/build_opened_date_field.rb"
require "tufy/fields/account/build_outstanding_balance_field.rb"
require "tufy/fields/account/build_partial_payment_field.rb"
require "tufy/fields/account/build_payment_frequency_field.rb"
require "tufy/fields/account/build_payment_amount_field.rb"
require "tufy/fields/account/build_past_due_amount_field.rb"
require "tufy/fields/account/build_reported_date_field.rb"
require "tufy/fields/account/build_restructured_account_number_field.rb"
require "tufy/fields/account/build_shared_by_field.rb"
require "tufy/fields/account/build_unbilled_balance_field.rb"
require "tufy/fields/account/build_user_id_field.rb"

module Tufy
  def self.transform_raw_data(raw_data)
    TransformRawData.execute(raw_data: raw_data)
  end

  def self.transform_raw_data_array(header_data, raw_data_array)
    TransformRawDataArray.execute({
      header_data: header_data,
      raw_data_array: raw_data_array
    })
  end
end
