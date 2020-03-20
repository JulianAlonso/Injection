# frozen_string_literal: true

require "fileutils"

class Utils

    def self.project_dir
        ENV["PWD"]
    end

    def self.injection_dir
        File.join(project_dir, "Injection")
    end

    def self.xcodeproj
        File.join(injection_dir, "Injection.xcodeproj")
    end
    
    def self.info_plist
        File.join(injection_dir, "Config/Injection.plist")
    end

end