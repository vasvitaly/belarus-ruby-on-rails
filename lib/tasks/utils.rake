namespace :utils do

  desc "Link site-specific config files and languages into config and localizations folders"
  task :set_site, [:site_name] => :environment do |t, args|
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

    puts styles_dir = File.join(Rails.root, 'app', 'assets', 'stylesheets')
    puts site_styles_dir = File.join(styles_dir, site_name)

    if File.directory?(site_styles_dir)
      puts "#{site_styles_dir} exists"
      puts Dir.glob("#{site_styles_dir}/*.sass")
      
      FileUtils.ln_s Dir.glob("#{site_styles_dir}/*.sass"), styles_dir, force: true
    end

    puts images_dir = File.join(Rails.root, 'app', 'assets', 'images')
    puts site_images_dir = File.join(Rails.root, 'app', 'assets', 'site_images', site_name, 'images')

    if File.directory?(site_images_dir)
      puts "link #{site_name} images into images folder"
      FileUtils.ln_s site_images_dir, images_dir, force: true
    end


  end
  
end
