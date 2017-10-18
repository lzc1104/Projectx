#
#  Be sure to run `pod spec lint Protos.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "Model"
  s.version      = "0.0.58"
  s.summary      = "This a Protos of protobuf generates files"
  s.ios.deployment_target = "8.0"
  s.homepage     = "http://cn.bing.com"
  s.license      = "MIT"
  s.author       = { "lzc1104" => "527004184@QQ.COM" }
  s.source       = { :git => 'https://github.com/google/protobuf.git' }

  s.source_files  = "Protos/**/*"
  # s.dependency "Protobuf"
  src = "./PBModels"
  pods_root = 'Pods'
  dir = "#{pods_root}/#{s.name}"
  protoc = "/usr/local/bin/protoc"
  s.prepare_command = <<-CMD
    mkdir -p #{dir}
        #{protoc} \
        --objc_out=#{dir} \
        -I #{src} \
        #{src}/*.proto
  CMD

  s.subspec "Message" do |ms|
    ms.source_files = "#{dir}/*.pbobjc.{h,m}","#{dir}/**/*.pbobjc.{h,m}"
    ms.header_mappings_dir = dir
    ms.requires_arc = false
    ms.dependency "Protobuf"
  end

  s.pod_target_xcconfig = {
    # This is needed by all pods that depend on Protobuf:
    'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS=1',
    # This is needed by all pods that depend on gRPC-RxLibrary:
    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
  }


end
