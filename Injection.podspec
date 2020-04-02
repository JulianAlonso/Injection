Pod::Spec.new do |spec|

  spec.name         = "Injection"
  spec.version      = "0.0.2"
  spec.summary      = "Injection, a Swift Lightweight dependency manager library."
  spec.description  = <<-DESC
  Swift Lightweight dependency manager library based on modules and components.
                   DESC

  spec.homepage     = "https://github.com/JulianAlonso/Injection"
  spec.license      =  { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "Julian Alonso" => "julian.alonso.dev@gmail.com" }
  spec.social_media_url   = "https://twitter.com/maisterjuli"

  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/JulianAlonso/Injection.git", :tag => "v#{spec.version}" }
  spec.swift_version = "5.1"
  spec.source_files  = "Injection/Sources/**/*"
  spec.requires_arc = true

end
