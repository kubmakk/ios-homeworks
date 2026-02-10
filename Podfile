platform :ios, '15.0'


def shared_pods
  pod 'FirebaseCore'
end

target 'Navigation' do
  use_frameworks!
  
  shared_pods

  pod 'Firebase/Auth'
  pod 'FirebaseFirestore'
  pod 'SnapKit'

  target 'NavigationTests' do
    inherit! :search_paths

  end
end

target 'Release' do
  use_frameworks!
  shared_pods
  
end

target 'StorageService' do
  use_frameworks!
  shared_pods
  
end
