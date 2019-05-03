Pod::Spec.new do |s|
s.name             = 'SAPermissionManager'
s.version          = '1.0'
s.summary          = 'Permission Library'
s.swift_version    = '4.2'

s.description      = <<-DESC
A repo that handle the permission asked by iOS from user like notification., contacts
DESC

s.homepage         = 'https://github.com/CrazyPro007/PermissionManager'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Shivank Agarwal' => 'shivank02agarwal@gmail.com' }
s.source           = { :git => 'https://github.com/CrazyPro007/PermissionManager.git', :tag => s.version.to_s }

s.ios.deployment_target = '11.0'
s.source_files = 'PermissionManager/PermissionManager/*.swift'

end
