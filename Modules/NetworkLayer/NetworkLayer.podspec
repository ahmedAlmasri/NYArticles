Pod::Spec.new  do |spec|

  spec.name         = "NetworkLayer"
  spec.version      = "0.0.1"
  spec.summary      = "A simple network abstraction layer written in Swift."
  spec.description  = "NetworkLayer"
  spec.homepage     = "http://EXAMPLE/NetworkLayer"
  spec.swift_version = "5.0"
  
  spec.author             = { "Ahmad Almasri" => "ahmed.almasri@ymail.com" }

  spec.platform     = :ios, "13.0"

  spec.source       = { :path => "." }

  spec.source_files  = "NetworkLayer/**/*.swift"
  spec.dependency 'Alamofire', '~> 5.0'
  spec.dependency 'RxSwift'


	spec.test_spec 'UnitTests' do |test_spec|
	test_spec.source_files = 'NetworkLayerTests/**/*.swift'
	test_spec.dependency 'Nimble'
	test_spec.dependency 'RxBlocking'
	end
end
