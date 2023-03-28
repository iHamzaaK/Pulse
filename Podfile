project 'Pulse.xcodeproj'

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Pulse' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
	pod 'Alamofire'
  pod 'Kingfisher'
  pod 'IQKeyboardManagerSwift'
  pod 'SimpleTwoWayBinding'
  pod 'CDAlertView'
  pod 'NVActivityIndicatorView'
  pod 'SlideMenuControllerSwift'
  pod 'ReadMoreTextView'
  pod 'RSSelectionMenu'
  pod 'SwiftEntryKit'
  pod 'TextFieldEffects'
  pod 'Alamofire-SwiftyJSON'
  pod 'ActionSheetPicker-3.0', '~> 2.3.0'
  pod 'SwiftEntryKit'
  pod 'OTPFieldView'
  pod 'YouTubePlayer'
  pod "ViewAnimator"
  pod 'AppCenter'



  # Pods for Pulse

end

# Disable signing for pods
post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
         end
    end
  end
end
