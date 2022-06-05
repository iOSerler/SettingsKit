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


## Usage
Create an object of **SettingsBuilder**2
Then push *settingsView*, property of the SettingsBuilder, to the *navigationController*

If you pass *nil* to all parameters SettingsBuilder will use *Default* configurations
For example:

```
let settingsPage = SettingsBuilder(
        analytics: nil,
        settingsSections: nil,
        notificationControlPanel: nil,
        notificationLocalSchedule: nil,
        settingsStyleConfigurable: nil
    )

self.navigationController?.pushViewController(settingsPage.settingsView, animated: true)
```
<!-- ![title](Images/example.png) -->



### Analytics
This parameter accepts *SettingsAnalytics*.
This is a protocol and the passed object should conform to it. For example:
```
struct Analytics: SettingsAnalytics{
    func logEvent(_ eventName: String, properties: [String:Any]?){
        ...
    }
    
    func setUserProperty(_ property: String, value: Any){
        ...
    }
}
```
If your settings page includes NotificationKit and DonationKit, The object should conform to protocol of [NotificationKit](https://github.com/iOSerler/NotificationKit) and [DonationKit](https://github.com/iOSerler/DonationKit). For example:
```
struct Analytics: SettingsAnalytics, NotificationKit.GenericAnalytics, DonationKit.AbstractAnalytics{
    func logEvent(_ eventName: String, properties: [String:Any]?){
        ...
    }
    
    func setUserProperty(_ property: String, value: Any){
        ...
    }
}
```
Basically this are the same protocols, but with different namings.


### SettingsSections
This parameter accepts array of *SettingsSection*
It is a protocol that conforms to *Decoable*. Example of the implementation can be found in **Model.swift** and in **StorageService.swift**. Since it is a *Decoadable*, it can be implemented with **Json**



<!-- [Link text Here](https://link-url-here.org) -->








