# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!

def testing_pods
    pod 'Quick', '1.3.2', :inhibit_warnings => true
    pod 'Nimble', '7.3.1', :inhibit_warnings => true
end

def app_pods
  pod 'ReactiveSwift', '4.0.0'
  pod 'ReactiveCocoa', '8.0.2'
  pod 'Result', '4.1.0'

  pod 'PureLayout', '3.1.4'
end

# target 'MyTests' do
#     testing_pods
# end

# target 'MyUITests' do
#     testing_pods
# end

# There are no targets called "Shows" in any Xcode projects
abstract_target 'App' do
  app_pods

  # Has its own copy of ShowsKit + ShowWebAuth
  target 'SampleContactList' do
      target 'SampleContactListTests' do
      inherit! :search_paths
      # Pods for testing
      testing_pods

    end
  end

  # Has its own copy of ShowsKit + ShowTVAuth
  target 'ContactListFramework' do

  end
end



# target 'SampleContactList' do
#   # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
#   app_pods


#   target 'SampleContactListTests' do
#     inherit! :search_paths
#     # Pods for testing
#     testing_pods

#   end

# end

# target 'ContactListFramework' do

# end


# # Podfile

# platform :ios, '9.0'

# use_frameworks!

# # My other pods

# def testing_pods
#     pod 'Quick', '0.5.0'
#     pod 'Nimble', '2.0.0-rc.1'
# end

# target 'MyTests' do
#     testing_pods
# end

# target 'MyUITests' do
#     testing_pods
# end
