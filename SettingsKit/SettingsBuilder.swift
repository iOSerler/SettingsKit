import Foundation
import UIKit
import NotificationKit

public final class SettingsBuilder {
    public let settingsView: SettingsView
    
    
    public init(
        analytics: SettingsAnalytics? = nil,
        settingsSections: [SettingsSection]? = nil,
        notificationControlPanel: [ControlPanelSection]? = nil,
        notificationLocalSchedule: LocalScheduler? = nil,
        settingsStyleConfigurable: SettingsStyleConfigurable? = nil
    ){
        let sections: [SettingsSection]
        
        if let settingsSections = settingsSections {
            sections = settingsSections
        } else {
            sections = StorageService().getControlPanel(from: "SettingsDefault")
        }
        
        self.settingsView = SettingsView(
            settingsSections: sections,
            analytics: analytics,
            controlPanel: notificationControlPanel,
            localSchedule: notificationLocalSchedule,
            settingsStyleConfigurable: settingsStyleConfigurable ?? SettingsStyleConfigurable()
        )
    }
}

