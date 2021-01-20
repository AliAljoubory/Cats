//
//  UIViewController.swift
//  Cats
//
//  Created by Ali Aljoubory on 28/12/2020.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentAlert(title: String, message: String, actionTitle: String, actionStyle: UIAlertAction.Style) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: actionTitle, style: actionStyle, handler: nil))
        present(ac, animated: true)
    }
    
    func getViewController(storyboard: String, identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: identifier)
        
        return viewController
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemBlue
        present(safariVC, animated: true)
    }
}
