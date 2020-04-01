//
//  InternetViewController.swift
//  Rent95
//
//  Created by Vadym on 14.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import UIKit
import Firebase

class InternetViewController: UIViewController {
    
    @IBOutlet weak var errorTextLabel: UILabel!
    
    let internetError = Notification.Name(rawValue: "Disconnected")
    let callNumber = NSLocalizedString("phoneNumber", comment: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func reloadButton(_ sender: UIButton) {
        // MARK: Reload webView request
        NotificationCenter.default.post(name: internetError, object: nil)
    }
    
    @IBAction func callButton(_ sender: Any) {
        
        callAction()
        
        // MARK: Send data to GA
        Analytics.logEvent("call_button_pressed", parameters: nil)
    }
    
    func callAction() {
        // MARK: Call
        let appPath = "telprompt://\(callNumber)"
        let appURL = URL(string: appPath)!
        let navigationAction = AppNavigation(appURL: appURL)
        navigationAction.openApp(from: self)
    }
}
