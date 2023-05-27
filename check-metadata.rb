require 'fileutils'

def check_content_length(path, length)
    data = File.open(path, :encoding => 'utf-8', &:read)
    
    if data.length > length
        STDERR.puts("File: #{path} is too long. Expected max #{length} actual: #{data.length}")
        exit(false)
    end
end

def main
    keywords_length = 100
    subtitle_length = 30
    
    check_content_length("Fastlane/metadata/cs/keywords.txt", keywords_length)
    check_content_length("Fastlane/metadata/cs/subtitle.txt", keywords_length)
    
    check_content_length("Fastlane/metadata/en-US/keywords.txt", keywords_length)
    check_content_length("Fastlane/metadata/en-US/subtitle.txt", keywords_length)
    
    check_content_length("Fastlane/metadata/pl/keywords.txt", keywords_length)
    check_content_length("Fastlane/metadata/pl/subtitle.txt", keywords_length)
    
    check_content_length("Fastlane/metadata/sk/keywords.txt", keywords_length)
    check_content_length("Fastlane/metadata/sk/subtitle.txt", keywords_length)
    
    check_content_length("Fastlane/metadata/uk/keywords.txt", keywords_length)
    check_content_length("Fastlane/metadata/uk/subtitle.txt", keywords_length)
    
    check_content_length("Fastlane/metadata/ru/keywords.txt", keywords_length)
    check_content_length("Fastlane/metadata/ru/subtitle.txt", keywords_length)
end

main()
