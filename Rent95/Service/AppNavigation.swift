//
//  AppNavigation.swift
//  Rent95
//
//  Created by Vadym on 01.04.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import UIKit

protocol AppNavigationProtocol {
    func openApp(from vc: UIViewController)
}

struct AppNavigation: AppNavigationProtocol {
    
    let appURL: URL
    let errorTitle = NSLocalizedString("error", comment: "")
    let errorMessage = NSLocalizedString("needInstall", comment: "")
    let alertTitle = NSLocalizedString("ok", comment: "")
    
    func openApp(from vc: UIViewController) {
        let app = UIApplication.shared
        if app.canOpenURL(appURL) {
            app.open(appURL, options: [:], completionHandler: nil)
        } else {
            let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: alertTitle, style: .cancel, handler: nil))
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
