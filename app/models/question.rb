class Question < ApplicationRecord
  def self.import(file)
    data = Roo::Excelx.new(file.tempfile)
    headers = data.row(1)

    data.each_with_index do |row, idx|
      next if idx == 0

      question_data = Hash[[headers, row].transpose]
      question_data = question_data.map { |k, v| [k ? (k.class == "String" ? k.strip : k) : k, v ? (v.class == "String" ? v.strip : v) : v] }.to_h

      Question.create(question_data)
    end
  end
end
