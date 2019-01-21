//
//  UIViewControllerExtension.swift
//  BSU Helper
//
//  Created by Ilya Sysoi on 10.04.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(withTitle title: String?,
                   withText text: String?,
                   completionBlock: ((UIAlertAction) -> ())?) {
        
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completionBlock))
        self.present(alert, animated: true, completion: nil)
    }
    
}
