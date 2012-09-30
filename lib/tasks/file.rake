namespace :file do

  def add_file(filename)
    filename = File.expand_path(filename)
    return unless File.exists?(filename)
    Asset.create do |a|
      a.filename = filename
      a.size = File.size(filename)
      a.content_type = `file -b --mime-type "#{filename}"`.chomp
    end
  end

  desc "list assets"
  task :list => :environment do
    Asset.all.each { |a| puts a.filename }
  end

  desc "add file"
  task :add, [:filename] => :environment do |t,args|
    file = args[:filename]
    raise "need to provide filename" unless file.presence
    puts "adding #{file}"
    a = add_file(file)
    if a.valid?
      print " - #{file} "
      puts a.short_urls.map { |link| link.link_id }.join(' ')
    end
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

