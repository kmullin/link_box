namespace :assets do
  desc "list assets"
  task :list => :environment do
    puts Asset.all
  end

  task :add_files => :environment do
    pwd = ENV['PWD']
    add_dir = ENV['ADD_DIR'] || pwd + '/files'
    puts add_dir
    current = []
    Dir.glob("#{add_dir}/**").each do |file|
      a = Asset.new
      base_name = File.basename(file)
      a.file_name = base_name
      current << base_name
      if Asset.where(:file_name => base_name).empty?
        puts file
        a.save
      end
    end

    assets = Asset.all.map { |a| a.file_name }
    stale = (assets - current).compact
    unless stale.empty?
      puts "STALE:"
      puts stale.join("\n")
    end
  end

end

