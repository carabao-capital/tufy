# v0.0.10

- Added account status constants
- Zero if interest_and_fees is negative

# v0.0.9

- Fix Address segment tag
- Fix Email Address segment tag
- Add Contact number type field
- Do not remove spaces from the address
- Pad the `account_number` and `restructured_account_number` with leading zeros
- Zero if outstanding_balance is negative
- "0000000000" if `contact_number` is `.empty?`
- Make the reported date field not required

# v0.0.8

- PARTIAL PAYMENT is now an optional field
- FRESH CASH ADVANCE is now an optional field
- UNBILLED_BALANCE is now an optional field
- CASH_ADVANCE_BALANCE is now an optional field

# v0.0.7

- Refactor each BuildSegment actions to be LightService::Organizers

# v0.0.6

- Added Tufy.transform_raw_data_array and refactor Tufy.transform
- Renamed Tufy::BuildAccountSegment.tu_past_due_code to ::past_due_code
- Use Unix timestamp for the Member Reference Number in the Header Segment

# v0.0.5

- Create method to return TU past due codes instead of using constants

# v0.0.4

- Fix: Added transformed_data key in ctx in Tufy::Transform

# v0.0.3

- Added TU Code for Number of Days Past Due in Tufy::BuildAccountSegment::Constants

# v0.0.2

- Refactor Tufy::Transform
