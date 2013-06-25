# encoding: utf-8
require Rails.root.join 'lib/importers/import'

desc "Импорт данных в формате *.csv"
task :import, [:file] => :environment do |t, args|
  Import.new(args[:file])
end
