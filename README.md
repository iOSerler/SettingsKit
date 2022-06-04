# SettingsKit

This is a static library that helps to build settings page quickly. Features that can be included into the settings page: 
 - Request a review in App Store
 - Share with others
 - Donation to an app   (with DonationKit)
 - Local notifications  (with NotificationKit)
 - Open any webpage


## Installation
Add to Podfile

```
use frameworks!

pod 'NotificationKit', :git => 'https://github.com/iOSerler/NotificationKit', :branch => 'main'
pod 'DonationKit', :git => 'https://github.com/iOSerler/DonationKit', :branch => 'main'
pod 'SettingsKit', :git => 'https://github.com/iOSerler/SettingsKit', :branch => 'main'
```

### Quick instruction for beginners in pod
First of all close the Xcode

If you do not have Podfile
- Need to create Podfile in the project folder. Run:
```pod init```
- Add the code above
- Then run:
```pod install```
- Then open .xcworkspace, with white icon, that has been created




