//
//  TextFieldExtension.swift
//  lab7
//
//  Created by Ilya Sysoi on 10.04.2018.
//  Copyright © 2018 Ilya Sysoi. All rights reserved.
//

import Foundation
import UIKit
extension UITextField {

    func addLeftOffsetToTextField(left: CGFloat) {
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: 5))
    }

}
