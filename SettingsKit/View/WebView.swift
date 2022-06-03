import UIKit
import WebKit

class WebController: UIViewController, UIWebViewDelegate {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var webView: UIWebView = {
        let view = UIWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var urlString: String?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadAddress()
        errorLabel.isHidden = true
        activityIndicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupViews() {
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        view.addSubview(webView)
        view.addSubview(errorLabel)
        view.addSubview(activityIndicator)
        
        
        if #available(iOS 11.0, *) {
            webView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
            webView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
            webView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        } else {
            webView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            webView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            webView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        }
        
        activityIndicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor, constant: 0).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor, constant: 0).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        errorLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 0).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor).isActive = true
        errorLabel.widthAnchor.constraint(equalTo: webView.widthAnchor, multiplier: 0.6).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
       
        
    }
    
    func loadAddress() {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            display(error: "No urlContentItem passed or url is missing")
            return
        }
        
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        display(error: error.localizedDescription)
    }
    
    func display(error: String) {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = false
        errorLabel.text = error
    }
}
