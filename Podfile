# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'NYArticles' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
	pod 'NetworkLayer', :path => 'Modules/NetworkLayer', :testspecs  => ['UnitTests']
	# DI
	pod "SwinjectAutoregistration"
	pod "Swinject"
	# UI
	pod "SnapKit"

	# RX
	pod "RxCocoa"

  target 'NYArticlesTests' do
    inherit! :search_paths
    pod 'RxBlocking'
  end

end
