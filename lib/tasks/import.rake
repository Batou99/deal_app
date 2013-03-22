require "#{Rails.root}/lib/support/loaders"

namespace :import do
  desc "Import daily planet file to DB"
  task :daily_planet, [:file]  => :environment do |t,args|
    file = args[:file] ||= "#{Rails.root}/script/data/daily_planet_export.txt"
    loader = Importer::DailyPlanetLoader.new
    loader.parse_file(file,true)
  end
end
