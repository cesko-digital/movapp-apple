require 'fileutils'

ORIGIN_FOLDER="tmp/data"
SOUNDS_FOLDER="Shared/Resources/Data/Sounds.xcassets"
STORIES_FOLDER="Shared/Resources/Data/Stories.xcassets"
ALPHABETS_FOLDER="Shared/Resources/Data/Alphabets.xcassets"
DICTIONARIES_FOLDER="Shared/Resources/Data/Dictionaries.xcassets"
TEAM_FOLDER="Shared/Resources/Data/Team.xcassets"

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

def folder_withoutpath_content_json(folder_path)
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
  destination_folder="Shared/Resources/Assets.xcassets/images"
  
  FileUtils.rm_rf(destination_folder)
  FileUtils.mkdir_p(destination_folder)
  
  Dir.entries(images_folder).select { |item|
    if item == "." || item == ".."
        next
    elsif File.directory?("#{images_folder}/#{item}")
        copy_images(images_folder, destination_folder, item)
    end
  }
  
  folder_content_json(destination_folder)
end

def copy_images(origin, destination, item)
  asset_path="#{destination}/#{item}/#{item}.imageset"
  image_path_prefix="#{origin}/#{item}/#{item}"

  FileUtils.mkdir_p(asset_path)
  FileUtils.cp("#{image_path_prefix}@1x.png", "#{asset_path}/#{item}@1x.png")
  FileUtils.cp("#{image_path_prefix}@2x.png", "#{asset_path}/#{item}@2x.png")
  FileUtils.cp("#{image_path_prefix}@3x.png", "#{asset_path}/#{item}@3x.png")
  
  imageset_content_json(asset_path, item)
  folder_withoutpath_content_json("#{destination}/#{item}")
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

def update_changelog_if_possible
  status = `git status -s`

  if status.empty? == false
      filename = "CHANGELOG.md"
      text = File.read(filename)
      puts = text.gsub("## [Unreleased]", "## [Unreleased]
- Update data from movapp-apple repository at #{Time.new}")
      File.open(filename, "w") { |file| file << puts }
  end
end

def main
    system("git clone https://github.com/cesko-digital/movapp-data.git tmp")

    puts "data..."

    puts "alphabets..."  
    copy_dataset(ALPHABETS_FOLDER, ORIGIN_FOLDER, "cs-uk-alphabet.json")
    copy_dataset(ALPHABETS_FOLDER, ORIGIN_FOLDER, "pl-uk-alphabet.json")
    copy_dataset(ALPHABETS_FOLDER, ORIGIN_FOLDER, "sk-uk-alphabet.json")
    copy_dataset(ALPHABETS_FOLDER, ORIGIN_FOLDER, "uk-cs-alphabet.json")
    copy_dataset(ALPHABETS_FOLDER, ORIGIN_FOLDER, "uk-pl-alphabet.json")
    copy_dataset(ALPHABETS_FOLDER, ORIGIN_FOLDER, "uk-sk-alphabet.json")
    puts "alphabets ✅"

    puts "sounds..."
    read_folder("cs-alphabet", SOUNDS_FOLDER, ORIGIN_FOLDER)
    read_folder("pl-alphabet", SOUNDS_FOLDER, ORIGIN_FOLDER)
    read_folder("sk-alphabet", SOUNDS_FOLDER, ORIGIN_FOLDER)
    read_folder("uk-alphabet", SOUNDS_FOLDER, ORIGIN_FOLDER)
    
    read_folder("cs-sounds", SOUNDS_FOLDER, ORIGIN_FOLDER)
    read_folder("pl-sounds", SOUNDS_FOLDER, ORIGIN_FOLDER)
    read_folder("sk-sounds", SOUNDS_FOLDER, ORIGIN_FOLDER)
    read_folder("uk-sounds", SOUNDS_FOLDER, ORIGIN_FOLDER)
    puts "sounds ✅"
    
    puts "dictionaries..."
    copy_dataset(DICTIONARIES_FOLDER, ORIGIN_FOLDER, "uk-cs-dictionary.json")
    copy_dataset(DICTIONARIES_FOLDER, ORIGIN_FOLDER, "uk-pl-dictionary.json")
    copy_dataset(DICTIONARIES_FOLDER, ORIGIN_FOLDER, "uk-sk-dictionary.json")
    puts "dictionaries ✅"

    puts "team..."
    copy_dataset(TEAM_FOLDER, ORIGIN_FOLDER, "team.v1.json")
    puts "team ✅"

    puts "data ✅"

    puts "images.."
    images()
    puts "images ✅"
    
    puts "stories.."
    read_folder("stories", STORIES_FOLDER, ORIGIN_FOLDER)
    puts "stories ✅"

    puts "🧹🧹🧹🧹🧹"
    FileUtils.rm_rf("tmp/", :verbose => true)
    
    puts "update changelog if possible"
    update_changelog_if_possible()
    
    puts "All ✅"
end

main()
