namespace :assets do
  desc "list assets"
  task :list => :environment do
    Asset.all.each { |a| puts a.file_name }
  end

  desc "Add files to database from /files or ENV['ADD_DIR']"
  task :add_files => :environment do
    add_dir = ENV['ADD_DIR'] || ENV['PWD'] + '/files'
    puts "Adding files from: " + add_dir
    current = []
    Dir.glob("#{add_dir}/**").each do |file|
      if File.directory?(file)
        puts " -> #{file} is directory... skipping."
      end
      a = Asset.new
      a.path = File.dirname(File.expand_path(file))
      a.file_name = File.basename(file)
      a.size = File.size(file)
      a.content_type = `file -b --mime-type "#{file}"`.gsub(/\n/,"")
      current << a.file_name
      if Asset.where(:file_name => a.file_name).empty?
        print " - #{a.file_name} "
        a.save
        url = a.short_urls.create
        puts url.link_id
      end
    end

    assets = Asset.all.map { |a| a.file_name }
    stale = (assets - current).compact
    unless stale.empty?
      puts "STALE:"
      stale.each { |s| puts " * " + s }
    end
  end

  desc "Remove all asset files from database"
  task :del_files => :environment do
    Asset.all.each do |a|
      puts a.file_name
      a.destroy
    end
  end

end

