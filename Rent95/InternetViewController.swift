//
//  InternetViewController.swift
//  Rent95
//
//  Created by Vadym on 14.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import UIKit

class InternetViewController: UIViewController {
    
    @IBOutlet weak var errorTextLabel: UILabel!
    
    let internetError = Notification.Name(rawValue: "Disconnected")
    let callNumber = NSLocalizedString("phoneNumber", comment: "Номер телефона")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func reloadButton(_ sender: UIButton) {
        // MARK: Отправляем запрос на перезагрузку webView
        NotificationCenter.default.post(name: internetError, object: nil)
    }
    
    @IBAction func callButton(_ sender: Any) {
        
        // MARK: Позвонить в компанию
        let app = UIApplication.shared
        let appPath = "telprompt://\(callNumber)"
        let appURL = URL(string: appPath)!

        if app.canOpenURL(appURL) {
            app.open(appURL, options: [:], completionHandler: nil)
        }
    }

}
