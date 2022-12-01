require 'fileutils'

ORIGIN_FOLDER="tmp/data"
DESTINATION_FOLDER="Shared/Assets.xcassets/data"

def read_folder(folder, destination_folder, origin_folder)
    folder_path="#{origin_folder}/#{folder}"
    destination_path="#{destination_folder}/#{folder}"
    
    FileUtils.rm_rf(destination_path)
    FileUtils.mkdir_p(destination_path)
    
    Dir.entries(folder_path).select { |item|
        if item == "." || item == ".."
            next
        elsif File.directory?("#{folder_path}/#{item}")
            read_folder(item, destination_path, folder_path)
        elsif File.extname(item) == ".json"
            copy_dataset(destination_path, folder_path, item)
        elsif File.extname(item) == ".mp3"
            copy_dataset(destination_path, folder_path, item)
        end
    }
    
    folder_content_json(destination_path)
end

def copy_dataset(to_folder, folder_path, file_name)
    asset_file="#{to_folder}/#{File.basename(file_name,".*")}.dataset"
    file_path="#{folder_path}/#{file_name}"
    
    FileUtils.mkdir_p(asset_file)
    FileUtils.cp(file_path, asset_file)
    dataset_content_json(asset_file, file_name)
end

def dataset_content_json(file_path, file_name)
    File.open("#{file_path}/Contents.json", "w") { |f| 
        f.write "{
  \"data\" : [
    {
      \"filename\" : \"#{file_name}\",
      \"idiom\" : \"universal\"
    }
  ],
  \"info\" : {
    \"author\" : \"xcode\",
    \"version\" : 1
  }
}
"
    }
end

def folder_content_json(folder_path)
  File.open("#{folder_path}/Contents.json", "w") { |f| 
        f.write "{
  \"info\" : {
    \"author\" : \"xcode\",
    \"version\" : 1
  },
  \"properties\" : {
    \"provides-namespace\" : true
  }
}
"
  }
end

def image_folder_content_json(folder_path)
  File.open("#{folder_path}/Contents.json", "w") { |f| 
      f.write "{
  \"info\" : {
    \"author\" : \"xcode\",
    \"version\" : 1
  }
}
"
  }
end

def images()
  images_folder="#{ORIGIN_FOLDER}/images/apple"
  destination_folder="Shared/Assets.xcassets/images"
  
  FileUtils.rm_rf(destination_folder)
  FileUtils.mkdir_p(destination_folder)
  
  Dir.entries(images_folder).select { |item|
    if item == "." || item == ".."
        next
    elsif File.directory?("#{images_folder}/#{item}")
        copy_images(images_folder, destination_folder, item)
    end
  }
end

def copy_images(origin, destination, item)
  asset_path="#{destination}/#{item}/#{item}.imageset"
  image_path_prefix="#{origin}/#{item}/#{item}"

  FileUtils.mkdir_p(asset_path)
  FileUtils.cp("#{image_path_prefix}@1x.png", "#{asset_path}/#{item}@1x.png")
  FileUtils.cp("#{image_path_prefix}@2x.png", "#{asset_path}/#{item}@2x.png")
  FileUtils.cp("#{image_path_prefix}@3x.png", "#{asset_path}/#{item}@3x.png")
  
  imageset_content_json(asset_path, item)
  image_folder_content_json("#{destination}/#{item}")
end

def imageset_content_json(path, item)
  File.open("#{path}/Contents.json", "w") { |f| 
      f.write "{
  \"images\" : [
    {
      \"filename\" : \"#{item}@1x.png\",
      \"idiom\" : \"universal\",
      \"scale\" : \"1x\"
    },
    {
      \"filename\" : \"#{item}@2x.png\",
      \"idiom\" : \"universal\",
      \"scale\" : \"2x\"
    },
    {
      \"filename\" : \"#{item}@3x.png\",
      \"idiom\" : \"universal\",
      \"scale\" : \"3x\"
    }
  ],
  \"info\" : {
    \"author\" : \"xcode\",
    \"version\" : 1
  }
}
"
  }
end

def main
    system("git clone git@github.com:cesko-digital/movapp-data.git tmp")

    puts "data..."
    read_folder("cs-alphabet", DESTINATION_FOLDER, ORIGIN_FOLDER)
    read_folder("cs-sounds", DESTINATION_FOLDER, ORIGIN_FOLDER)
    read_folder("pl-alphabet", DESTINATION_FOLDER, ORIGIN_FOLDER)
    read_folder("pl-sounds", DESTINATION_FOLDER, ORIGIN_FOLDER)
    read_folder("sk-alphabet", DESTINATION_FOLDER, ORIGIN_FOLDER)
    read_folder("sk-sounds", DESTINATION_FOLDER, ORIGIN_FOLDER)
    read_folder("uk-alphabet", DESTINATION_FOLDER, ORIGIN_FOLDER)
    read_folder("uk-sounds", DESTINATION_FOLDER, ORIGIN_FOLDER)
    copy_dataset(DESTINATION_FOLDER, ORIGIN_FOLDER, "cs-uk-alphabet.json")
    copy_dataset(DESTINATION_FOLDER, ORIGIN_FOLDER, "pl-uk-alphabet.json")
    copy_dataset(DESTINATION_FOLDER, ORIGIN_FOLDER, "sk-uk-alphabet.json")
    copy_dataset(DESTINATION_FOLDER, ORIGIN_FOLDER, "team.v1.json")
    copy_dataset(DESTINATION_FOLDER, ORIGIN_FOLDER, "uk-cs-alphabet.json")
    copy_dataset(DESTINATION_FOLDER, ORIGIN_FOLDER, "uk-cs-dictionary.json")
    copy_dataset(DESTINATION_FOLDER, ORIGIN_FOLDER, "uk-pl-alphabet.json")
    copy_dataset(DESTINATION_FOLDER, ORIGIN_FOLDER, "uk-pl-dictionary.json")
    copy_dataset(DESTINATION_FOLDER, ORIGIN_FOLDER, "uk-sk-alphabet.json")
    copy_dataset(DESTINATION_FOLDER, ORIGIN_FOLDER, "uk-sk-dictionary.json")
    puts "data ✅"

    puts "images.."
    images()
    puts "images ✅"

    puts "🧹🧹🧹🧹🧹"
    FileUtils.rm_rf("tmp/", :verbose => true)
    puts "All ✅"
end

main()
