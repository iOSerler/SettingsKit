
import UIKit


class SettingsCell: UITableViewCell {
    static let reusableCellIdentifier = "SettingsCellId"
    var rowHeight: CGFloat = 45
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let titleBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue.withAlphaComponent(0.7)
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        
        
        addSubview(titleBackgroundView)
        contentView.addSubview(titleLabel)
        
        //need x,y,width,height anchors
        titleBackgroundView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 2).isActive = true
        titleBackgroundView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        titleBackgroundView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2).isActive = true
        titleBackgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 1).isActive = true
        titleBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        //need x,y,width,height anchors
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -64).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



public class SettingsStyleConfigurable {
    let reusableCellIdentifier: String
    
    let rowHeight: CGFloat
    let rowFont: UIFont
    let rowTextColor: UIColor
    let rowBackgroundColor: UIColor
    
    let headerHeight: CGFloat
    let headerFont: UIFont
    let headerTextColor: UIColor
    let headerBackgroundColor: UIColor
    
    let pageBackgroundColor: UIColor
    
    
    public init(
        reusableCellIdentifier: String = "SettingsCellId",
        rowHeight: CGFloat = 45,
        rowFont: UIFont = UIFont.systemFont(ofSize: 17, weight: .regular),
        rowTextColor: UIColor = UIColor.black,
        rowBackgroundColor: UIColor = UIColor.white,
        headerHeight: CGFloat = 40,
        headerFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .medium),
        headerTextColor: UIColor = UIColor.darkGray,
        headerBackgroundColor: UIColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1),
        pageBackgroundColor: UIColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    ) {
        self.reusableCellIdentifier = reusableCellIdentifier
        
        self.rowHeight = rowHeight
        self.rowFont = rowFont
        self.rowTextColor = rowTextColor
        self.rowBackgroundColor = rowBackgroundColor
        
        self.headerHeight = headerHeight
        self.headerFont = headerFont
        self.headerTextColor = headerTextColor
        self.headerBackgroundColor = headerBackgroundColor
        
        self.pageBackgroundColor = pageBackgroundColor
    }
        
}

