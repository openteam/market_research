# encoding: utf-8

require 'csv'

class Import

  def initialize(path)
    @path = path

    import
  end

  def import
    bar = ProgressBar.new prepare_hash.size
    prepare_hash.each do |record|
      import_record record
      bar.increment!
    end
  end

  def import_record(record)
    Item.create(:data => OpenStruct.new(record))
  end

private
  def prepare_hash
    csv_data = CSV.read @path
    headers = csv_data.shift.map {|i| i.to_s }
    string_data = csv_data.map {|row| row.map {|cell| cell.to_s } }
    string_data.map {|row| Hash[*headers.zip(row).flatten] }
  end
end
