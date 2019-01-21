//
//  UITextFieldExtension.swift
//  BSU Helper
//
//  Created by Ilya Sysoi on 28.02.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func addLeftOffsetToTextField(left: Int) {
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: 5))
    }
    
}
