namespace :utils do

  desc "Link site-specific config files and languages into config and localizations folders"
  task :link_configs, [:site_name] => :environment do |t, args|
    unless args[:site_name]
      puts "Please pass site folder name as first parameter rake utils:link_configs[site_folder]. Find site-folders in config/site-specific"
      exit
    end

    site_name = args[:site_name]
    puts config_dir = File.join(Rails.root, "config")
    puts site_dir = File.join(config_dir, 'site_specific', site_name)

    if File.directory?(site_dir)
      puts "#{site_dir} exists"
      # puts Dir.glob("#{site_dir}/**/*.yml")
      # puts Dir.glob("#{site_dir}/**")
      Dir.glob("#{site_dir}/**/*.yml").each do |file_path|
        symlink_path = file_path.gsub(site_dir, config_dir)
        puts "symlink  #{file_path} to #{symlink_path}"
        FileUtils.ln_s file_path, symlink_path, force: true
      end
    end
  end
  
end
