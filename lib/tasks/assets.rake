namespace :assets do
  desc "list assets"
  task :list => :environment do
    Asset.all.each { |a| puts a.filename }
  end

  desc "Recursively add directory to database from /files or ENV['ADD_DIR']"
  task :add_dir => :environment do
    add_dir = ENV['ADD_DIR'] || ENV['PWD'] + '/files'
    puts "Adding files from: " + add_dir
    current = []
    Dir.glob("#{add_dir}/**").each do |file|
      if File.directory?(file)
        puts " -> #{file} is directory... skipping."
        next
      end
      a = Asset.new
      a.path = File.dirname(File.expand_path(file))
      a.filename = File.basename(file)
      a.size = File.size(file)
      a.content_type = `file -b --mime-type "#{file}"`.gsub(/\n/,"")
      current << a.filename
      if Asset.where(:filename => a.filename).empty?
        print " - #{a.filename} "
        a.save
        puts a.short_urls.first.link_id
      end
    end

    assets = Asset.all.map { |a| a.filename }
    stale = (assets - current).compact
    unless stale.empty?
      puts "STALE:"
      stale.each { |s| puts " * " + s }
    end
  end

  desc "Remove all asset files from database"
  task :clear => :environment do
    Asset.all.each do |a|
      puts a.filename
      a.destroy
    end
  end

end

