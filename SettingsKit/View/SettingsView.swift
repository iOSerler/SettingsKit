import UIKit
import SafariServices
import StoreKit
import Foundation
import NotificationKit


public protocol SettingsViewDelegate {
    func openDonateProposition()
}


public final class SettingsView: UIViewController {
    public var settingsViewDelegate: SettingsViewDelegate?
    
    private var settingsSections: [SettingsSection]
    private var analytics: SettingsAnalytics?
    
    private var notificationControlPanel: [ControlPanelSection]?
    private var notificationSchedule: LocalScheduler?
    
    private var settingsStyleConfigurable: SettingsStyleConfigurable
    
    private struct Constants {
        static let cellHeight: CGFloat = 45
        static let headerHeight: CGFloat = 40
        static let estimatedRowHeight: CGFloat = 60
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.showsVerticalScrollIndicator = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: settingsStyleConfigurable.reusableCellIdentifier)
        return tableView
    }()
    
    init(
        settingsSections: [SettingsSection],
        analytics: SettingsAnalytics?,
        controlPanel: [ControlPanelSection]?,
        localSchedule: LocalScheduler?,
        settingsStyleConfigurable: SettingsStyleConfigurable
    ) {
        self.settingsSections = settingsSections
        self.analytics = analytics
        
        self.notificationControlPanel = controlPanel
        self.notificationSchedule = localSchedule
        
        self.settingsStyleConfigurable = settingsStyleConfigurable
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.addSubview(tableView)
        applyConstraints()
        reloadData()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func reloadData() {
        settingsSections = settingsSections.map { sectionConstant in
            var section = sectionConstant
            section.items = sectionConstant.items.filter {
                $0.isShown
            }
            return section
        }.filter {
            $0.items.isEmpty == false
        }
        tableView.reloadData()
    }
    
    func shareApp() {
        let urlString = "https://apple.co/39pI1kl"
        
        let alert = UIActivityViewController(activityItems: [urlString], applicationActivities: nil)
        
        // if we're on iPad there is nowhere sensible to anchor this from, so just center it
        if let popOver = alert.popoverPresentationController {
            popOver.sourceView = self.navigationController!.view
            popOver.sourceRect = CGRect(x: self.navigationController!.view.frame.midX, y: self.navigationController!.view.frame.midY, width: 0, height: 0)
        }
        
        self.navigationController!.present(alert, animated: true)
    }
    
    func supportUs(_ associatedBonusItemId: String? = nil) {
        guard let settingsViewDelegate = settingsViewDelegate else {
            return
        }
        settingsViewDelegate.openDonateProposition()
    }
    
    func openWebPage(_ settingsItem: SettingsItem){
        guard let urlString = settingsItem.url, let url = URL(string: urlString) else { return }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
    func openNotificationPanel() {
        let notificationBuilder = NotificationModuleBuilder(
            controlPanel: notificationControlPanel,
            notificationScheduler: notificationSchedule,
            analytics: analytics as? GenericAnalytics
        )
        
        self.navigationController?.pushViewController(notificationBuilder.view, animated: true)
    }
    
    func requestReview(_ circumstance: String = "Launch") {
        if #available(iOS 10.3, *) {
            
            analytics?.logEvent("Requesting review", properties: [
                "circumstance": circumstance,
            ])

            DispatchQueue.main.async {
                SKStoreReviewController.requestReview()
            }

        } else {
            // Fallback on earlier versions
            // Try any other 3rd party or manual method here.
        }
    }
    
    public func addSections(sections: [SettingsSection]) {
        for section in sections {
            if !settingsSections.contains(where: {$0.id == section.id}) {
                settingsSections.append(section)
            }
        }
        tableView.reloadData()
    }
}

extension SettingsView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = settingsSections[indexPath.section]
        let item = section.items[indexPath.row]
        
        switch (item.id, item.type) {
        case (_, "page"), (_, "article"):
            openWebPage(item)
        case ("share_app",_):
            shareApp()
        case ("support_app",_):
            supportUs()
        case ("rate_app",_):
            requestReview("Settings")
        case ("notification", _):
            openNotificationPanel()
        default:
            break
        }
    }
}


extension SettingsView: UITableViewDataSource {
    
   
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.settingsSections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingsSections[section].items.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        settingsSections[section].title
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = settingsSections[indexPath.section]
        let item = section.items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: settingsStyleConfigurable.reusableCellIdentifier, for: indexPath)
        cell.textLabel?.text = item.title
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
}

