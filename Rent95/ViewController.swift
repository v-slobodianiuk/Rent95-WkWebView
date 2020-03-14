//
//  ViewController.swift
//  Rent95
//
//  Created by Vadym on 14.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
    let internetError = Notification.Name(rawValue: "Disconnected")
    var cURL = NSLocalizedString("siteURL", comment: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Меняем размер ProgressView
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 3)
        
        // MARK: Наблюдатели
        NotificationCenter.default.addObserver(self, selector: #selector(lostConnection(_:)), name: internetError, object: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        // MARK: Подписываемся на нужные делегаты
        webView.uiDelegate = self
        webView.navigationDelegate = self
    
        loadWebView()

        // MARK: Скрываем полосы прокрутки на экране
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
    }
    
    // MARK: - Кнопки навигации в webView
    @IBAction func backButton(_ sender: Any) {
        guard webView.canGoBack else { return }
        webView.goBack()
    }
    
    // MARK: - Загружаем контент WebView
    func loadWebView() {
        let myURL = URL(string:cURL)
        let myRequest = URLRequest(url: myURL!, timeoutInterval: 8.0)
        webView.load(myRequest)
    }
    
    // MARK: - Отслеживаем прогресс загружки контента webView
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath != "estimatedProgress" else { return }
        progressView.progress = Float(webView.estimatedProgress)
    }
    
    // MARK: - Селектор наблюдателя за состоянием работы интернета
    @objc func lostConnection(_ n: Notification) {
        loadWebView()
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: webView готов к загрузке контента
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //NSLog("Ready to Load Page")
    }
    
    // MARK: webView загружает контент
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //NSLog("Start loading page")
        if !logo.isHidden { logo.isHidden = true }
        progressView.isHidden = false
    }
    
    // MARK: webView завершил загрузку контента
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.isHidden = true
        //NSLog("Finish loading page")

    }
    
    // MARK: - Нет подключения к сети
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        // MARK: Сохраняем текущий url для загрузки при подключении к интернету
        if let url = webView.url { cURL = "\(url)" }
        webView.stopLoading()
        
        // MARK: - Переход на InternetViewController
        let internetVC = self.storyboard?.instantiateViewController(withIdentifier: "internetVC") as! InternetViewController
        self.present(internetVC, animated: true, completion: nil)
    }
    
}

