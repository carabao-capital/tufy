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
