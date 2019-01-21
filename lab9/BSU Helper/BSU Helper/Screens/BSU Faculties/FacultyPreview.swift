//
//  FacultyPreview.swift
//  BSU Helper
//
//  Created by Ilya Sysoi on 4/28/18.
//  Copyright © 2018 isysoi. All rights reserved.
//

import UIKit

class FacultyPreview: UIView {

    private var logoImageView: UIImageView
    private var nameLabel: UILabel
    
    init(item: FacultyItem) {
        let image = UIImage(named: item.logoName)
        logoImageView = UIImageView(image: image)
        nameLabel =  UILabel()
        super.init(frame: .zero)
        
        nameLabel.text = item.name
        confiqureSubviews()
        addSubviews()
        confiqureConstraints()
    }
    
    private func confiqureSubviews() {
        nameLabel.numberOfLines = 3
    }
    
    private func addSubviews() {
        addSubview(logoImageView)
        addSubview(nameLabel)
    }
    
    private func confiqureConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.left.equalTo(self)
            make.height.width.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(15)
            make.width.equalTo(220)
            //make.right.equalTo(self)
        }
        
        self.snp.makeConstraints { make in
            make.bottom.equalTo(logoImageView).priority(.medium)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
