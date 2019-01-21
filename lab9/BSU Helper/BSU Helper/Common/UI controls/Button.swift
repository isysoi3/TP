//
//  CustomButton.swift
//  BSU Helper
//
//  Created by Ilya on 11/13/17.
//  Copyright © 2017 Ilya. All rights reserved.
//

import UIKit


class Button: UIButton {
    
    typealias onTapBlock = (Button) -> ()

    private var tapBlock: onTapBlock?
    
    init(title: String, tapBlock: @escaping onTapBlock){
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        addTargetClosure(closure: tapBlock)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTargetClosure(closure: @escaping onTapBlock) {
        tapBlock = closure
        addTarget(self, action: #selector(Button.closureAction), for: .touchUpInside)
    }
    
    @objc func closureAction() {
        guard let tapBlock = tapBlock else {
            return
        }
        tapBlock(self)
    }
    
}
