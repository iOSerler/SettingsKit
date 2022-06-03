import Foundation


public protocol SettingsSection: Decodable {
    var id: String { get }
    var title: String { get }

    var items: [SettingsItem] { get  set }
}

public protocol SettingsItem: Decodable {
    var id: String { get }
    var type: String { get }

    var title: String { get }
    var detail: String? { get }
    var url: String? { get }

    var isShown: Bool { get }
}




public struct SettingsSectionDefault: SettingsSection {
    public let id: String
    public let title: String
    public var items: [SettingsItem]
    
    
    init(id: String, title: String, items: [SettingsItemDefault]) {
        self.id = id
        self.title = title
        self.items = items
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, items
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        items = try values.decode([SettingsItemDefault].self, forKey: .items)
    }
    
}

public struct SettingsItemDefault: SettingsItem {
    public let id: String
    public let type: String
    public let title: String
    public let detail: String?
    public let url: String?
    public var isShown: Bool
    
    
    init(id: String, type: String, title: String, detail: String?, url: String?, isShown: Bool) {
        self.id = id
        self.type = type
        self.title = title
        
        self.detail = detail ?? ""
        self.url = url ?? ""
        
        self.isShown = isShown
    }
}
