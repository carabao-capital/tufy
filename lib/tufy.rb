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
