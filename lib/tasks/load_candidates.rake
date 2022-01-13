require 'roo'

namespace :load_candidates do
  desc "Import data from spreadsheet"

  task data: :environment do
    puts 'Importing Data' # add this line
    data = Roo::Spreadsheet.open("lib/candidates.xlsx") # open spreadsheet
    headers = data.row(1)

    data.each_with_index do |row, idx|
      next if idx == 0 # skip header row
      user_data = Hash[[headers, row].transpose]
      user_data = user_data.map { |k, v| [k ? (k.class == "String" ? k.strip : k) : k, v ? (v.class == "String" ? v.strip : v) : v] }.to_h

      User.create(user_data)
    end
    
    p "***Updated Succefully***"
  end
end
