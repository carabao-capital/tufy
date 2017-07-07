[![Gem Version](https://badge.fury.io/rb/tufy.png)](https://badge.fury.io/rb/tufy)

# Tufy

"Pronounced as T-U-fy"
Helper gem to convert any raw data into TU-readable format.

### More Information
See the [TUDF ver. 11 Guide](https://www.dropbox.com/s/ohx8rgdixwwfarw/tudf_guide_version_11.pdf?dl=0) and the [TUDF ver. 11 Walkthrough](https://www.dropbox.com/s/1g1m7797spwpy09/tudf_walkthrough_version_11.pdf?dl=0)

### Installation

```sh
$ gem install tufy
```

### Usage
#### 1. Tufy.transform_raw_data_array(header_data, raw_data_array)


```ruby
transform_raw_data_array_result =
    Tufy.transform_raw_data_array(
      {
        # for the header segment
        member_reference_number: member_reference_number,
        processor_name: processor_name,
        user_id: user_id,
      },
      [
        {
          # for the name segment
          first_name: first_name,
          last_name: last_name,
          civil_status: civil_status,
          date_of_birth: date_of_birth,
          gender: gender,
          ac_holder_type: ac_holder_type,
          # for the id segment
          id_number: id_number,
          id_type: id_type,
          # for the address segment
          address_line_1: address_line_1,
          address_line_2: address_line_2,
          address_type: address_type,
          # for contact number segment
          contact_number: contact_number,
          contact_number_format: contact_number_format,
          # for email address segment
          email_address: email_address,
          # for account segment
          account_number: account_number,
          restructured_account_number: restructured_account_number,
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
        },
      ]
    )
```

#### 2. Tufy.transform_raw_data(raw_data)


```ruby
transform_raw_data_result =
    Tufy.transform_raw_data(
      {
        # for the name segment
        first_name: first_name,
        last_name: last_name,
        civil_status: civil_status,
        date_of_birth: date_of_birth,
        gender: gender,
        ac_holder_type: ac_holder_type,
        # for the id segment
        id_number: id_number,
        id_type: id_type,
        # for the address segment
        address_line_1: address_line_1,
        address_line_2: address_line_2,
        address_type: address_type,
        # for contact number segment
        contact_number: contact_number,
        contact_number_format: contact_number_format,
        # for email address segment
        email_address: email_address,
        # for account segment
        account_number: account_number,
        restructured_account_number: restructured_account_number,
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
    )
```

### Supported Data

| Segment | Field | Supported? |
| ------ | ------ | ------ |
| Header | MEMBER REFERENCE NUMBER | ✓ |
|| PROCESSOR NAME | ✓ |
|| USER ID | ✓ |
| Name | Multiple Entries | |
| | FIRST NAME | ✓ |
| | MIDDLE NAME ||
| | LAST NAME | ✓ |
| | MOTHER'S MAIDEN FULL NAME | |
| | CIVIL STATUS  | ✓ |
| | DATE OF BIRTH | ✓ |
| | GENDER | ✓ |
| | NATIONALITY | |
| | NUMBER OF DEPENDENTS | |
| | HOME OWNERSHIP | |
| | CAR OWNERSHIP | |
| | A/C HOLDER TYPE | ✓ |
| | DISPUTE | |
| Id | Multiple Entries | |
| | ID NUMBER | ✓ |
| | ID TYPE | ✓ |
| Alias | Multiple Entries | |
| | FIRST NAME | |
| | MIDDLE NAME | |
| | LAST NAME | |
| | MOTHER'S MAIDEN FULL NAME | |
| Address | Multiple Entries | |
| | ADDRESS LINE 1 | ✓ |
| | ADDRESS LINE 2 | ✓ |
| | ZIP CODE | |
| | TYPE| ✓ |
| Contact Number | Multiple Entries | |
| | COUNTRY CODE |  |
| | AREA CODE | |
| | CONTACT NUMBER | ✓ |
| | EXT/CALL | |
| | FORMAT | ✓ |
| Email Address | Multiple Entries | |
| | EMAIL ADDRESS | ✓ |
| Employment | COMPANY NAME ||
| | NATURE OF BUSINESS |  |
| | EMPLOYMENT TYPE |  |
| | OCCUPATION |  |
| | LENGTH OF EMPLOYMENT IN YEARS |  |
| | LENGTH OF EMPLOYMENT IN MONTHS |  |
| | CURRENCY CODE |  |
| | CONSUMER ANNUAL INCOME |  |
| Education | EDUCATION LEVEL | |
| Account | ACCOUNT NUMBER | ✓ |
| | RESTRUCTURED ACCOUNT NUMBER | ✓ |
| | USER ID | ✓ |
| | ACCOUNT STATUS | ✓ |
| | ACCOUT TYPE | ✓ |
| | CURRENCY CODE | ✓ |
| | OPENED DATE | ✓ |
| | PAYMENT AMOUNT | ✓ |
| | CLOSED DATE | ✓ |
| | CREDIT LIMIT OR LOAN AMOUNT | ✓ |
| | SHARED BY | ✓ |
| | OUTSTANDING BALANCE | ✓ |
| | INTEREST AND FEES | ✓ |
| | UNBILLED BALANCE | ✓ |
| | CASH ADVANCE BALANCE | ✓ |
| | NUMBER OF DAYS PAST DUE | ✓ |
| | PAST DUE AMOUNT | ✓ |
| | INSTALLMENT AMOUNT | ✓ |
| | NUMBER OF INSTALLMENTS | ✓ |
| | PAYMENT FREQUENCY | ✓ |
| | EXPIRY DATE | ✓ |
| | CONSUMER OR COMMERCIAL | ✓ |
| | LEGAL ACTION | ✓ |
| | PARTIAL PAYMENT | ✓ |
| | FRESH CASH ADVANCE | ✓ |

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

