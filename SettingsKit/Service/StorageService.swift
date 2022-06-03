import Foundation
//import class Foundation.Bundle

struct StorageService {
    
    enum StorageError: Error {
        case noFilePathError(String)
    }
    
    
    func getControlPanel(from fileName: String) -> [SettingsSection] {
        return getSettingsDefaults()
    }
    
    
    func getSettingsDefaults() -> [SettingsSectionDefault] {
        var defaults: [SettingsSectionDefault] = []
        
        let section_general = SettingsSectionDefault(
            id: "genral",
            title: "General",
            items: [
                SettingsItemDefault(
                    id: "share_app",
                    type: "action",
                    title: "Share with others",
                    detail: nil,
                    url: nil,
                    isShown: true
                ),
                SettingsItemDefault(
                    id: "rate_app",
                    type: "action",
                    title: "Rate us in the AppStore",
                    detail: "Your ratings and reviews will help us reach more people",
                    url: nil,
                    isShown: true
                ),
                SettingsItemDefault(
                    id: "contact_developer",
                    type: "page",
                    title: "Contact the developer",
                    detail: nil,
                    url: "https://wa.me/77765206766",
                    isShown: true
                ),
                SettingsItemDefault(
                    id: "support_app",
                    type: "action",
                    title: "Donate to the developers",
                    detail: nil,
                    url: nil,
                    isShown: true
                ),
                SettingsItemDefault(
                    id: "notification",
                    type: "view",
                    title: "Notifications",
                    detail: nil,
                    url: nil,
                    isShown: true
                ),
            ]
        )
        
        let section_ioserler = SettingsSectionDefault(
            id: "ioserler",
            title: "iOSerler Developers",
            items: [
                SettingsItemDefault(
                    id: "ioserler",
                    type: "page",
                    title: "iOSerler",
                    detail: nil, url: "https://github.com/orgs/iOSerler/repositories",
                    isShown: true
                )
            ]
        )
        
        defaults.append(section_general)
        defaults.append(section_ioserler)
        
        return defaults
    }
    
}
