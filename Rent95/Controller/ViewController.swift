//
//  ViewController.swift
//  Rent95
//
//  Created by Vadym on 14.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import UIKit
import WebKit
import Firebase

class ViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var buttonView: CustomUIView!
    
    let internetError = Notification.Name(rawValue: "Disconnected")
    var cURL = NSLocalizedString("siteURL", comment: "")
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Sign for Delegates
        webView.navigationDelegate = self
        
        // MARK: Scale ProgressView
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 3)
        
        webViewSettings()
        loadWebView()
        
        // MARK: Observers
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(lostConnection(_:)), name: internetError, object: nil)
    }
    
    // MARK: - Methods
    
    // MARK: webView Setting
    func webViewSettings() {

        // MARK: Force Touch
        webView.allowsLinkPreview = false
        
        // MARK: Navigation swipes
        webView.allowsBackForwardNavigationGestures = true
        
        // MARK: Hide back button
        backButton.isHidden = true
        buttonView.isHidden = true
        
        // MARK: Hide scrollView
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
    }
    
    // MARK: webView load request
    func loadWebView() {
        let myURL = URL(string:cURL)
        let myRequest = URLRequest(url: myURL!, timeoutInterval: 8.0)
        webView.load(myRequest)
    }
    
    // MARK: webView loading progress
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "estimatedProgress":
            progressView.progress = Float(webView.estimatedProgress)
        case "canGoBack":
            self.backButton.isHidden = !self.webView.canGoBack
            self.buttonView.isHidden = !self.webView.canGoBack
        default:
            break
        }
    }
    
    // MARK: webView Navigation button
    @IBAction func backButton(_ sender: Any) {
        webView.goBack()
    }
    
    // MARK: lostConnection selector
    @objc func lostConnection(_ n: Notification) {
        loadWebView()
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Open external app method if needed
    func navAction(for navigationAction: WKNavigationAction, _ decisionHandler: (WKNavigationActionPolicy) -> Void) {
        let navigationAction = AppNavigation(appURL: navigationAction.request.url!)
        navigationAction.openApp(from: self)
        decisionHandler(.cancel)
    }
}

// MARK: - WKNavigationDelegate
extension ViewController: WKNavigationDelegate {
    
    // MARK: webView ready to load page
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.isHidden = false
    }
    
    // MARK: webView Start loading page
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if !logo.isHidden { logo.isHidden = true }
    }
    
    // MARK: webView Finish loading page
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.isHidden = true
    }
    
    // MARK: webView navigation actions
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        
        // MARK: Navigation schemes
        switch navigationAction.request.url?.scheme {
        case AppScheme.App.phone.rawValue:
            navAction(for :navigationAction, decisionHandler)
            Analytics.logEvent("call_button_pressed", parameters: nil)
        case AppScheme.App.mail.rawValue:
            navAction(for :navigationAction, decisionHandler)
            Analytics.logEvent("mail_button_pressed", parameters: nil)
        case AppScheme.App.viber.rawValue:
            navAction(for :navigationAction, decisionHandler)
            Analytics.logEvent("viber_button_pressed", parameters: nil)
        case AppScheme.App.telegram.rawValue:
            navAction(for :navigationAction, decisionHandler)
            Analytics.logEvent("telegram_button_pressed", parameters: nil)
            case AppScheme.App.whatsapp.rawValue:
            navAction(for :navigationAction, decisionHandler)
            Analytics.logEvent("whatsapp_button_pressed", parameters: nil)
        default:
            decisionHandler(.allow)
        }
    }
    
    // MARK: No internet connection
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let nserror = error as NSError
        
        guard nserror.code != -999 else { return }
        
        // MARK: Save current url for loading after success status connection
        if let url = webView.url { cURL = "\(url)" }
        webView.stopLoading()
        
        // MARK: Go to InternetViewController
        let internetVC = self.storyboard?.instantiateViewController(withIdentifier: "internetVC") as! InternetViewController
        self.present(internetVC, animated: true, completion: nil)
    }
}
