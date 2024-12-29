require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-simple-openvpn"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-simple-openvpn
                   DESC
  s.homepage     = "https://github.com/bobwei/react-native-simple-openvpn"
  s.license      = { :type => "GPLv2", :file => "LICENSE" }
  s.authors      = { "Nor Cod" => "norfecod@outlook.com" }
  s.platforms    = { :ios => "15.6" }
  s.source       = { :git => "https://github.com/bobwei/react-native-simple-openvpn.git" }

  s.source_files = "ios/**/*.{h,c,cc,cpp,m,mm,swift}"
  s.requires_arc = true

  s.dependency "React"
end
