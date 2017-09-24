Pod::Spec.new do |s|
  s.name = 'InfoKit'
  s.version = '0.0.2'
  s.license = 'MIT'
  s.summary = 'Strongly Typed access to Info.plist, for iOS, macOS and tvOS.'
  s.homepage = 'https://github.com/nmdias/InfoKit'
  s.authors = { 'Nuno Manuel Dias' => 'nmdias.pt@gmail.com' }
  s.source = { :git => 'https://github.com/nmdias/InfoKit.git', :tag => s.version }
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'
  s.source_files = 'Sources/**/*.swift'
end
