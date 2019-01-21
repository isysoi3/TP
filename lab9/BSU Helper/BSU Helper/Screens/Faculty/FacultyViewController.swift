//
//  FacultyViewController.swift
//  BSU Helper
//
//  Created by Ilya Sysoi on 4/28/18.
//  Copyright © 2018 isysoi. All rights reserved.
//

import UIKit

class FacultyViewController: UIViewController {

    private var backButton: Button
    private var logoImageView: UIImageView
    private var nameLabel: UILabel
    private var descriptionLabel: UILabel
    private var headlaLabel: UILabel
    private var dateOfCreationLabel: UILabel
    private var specialityStackView: UIStackView
    private var scrollView: UIScrollView
    private var contentView: UIView
    
    
    init(item: FacultyItem) {
        backButton = Button(title: "<",
                            tapBlock: {_ in })
        logoImageView = UIImageView(image: UIImage(named: item.logoName))
        nameLabel = UILabel()
        descriptionLabel = UILabel()
        headlaLabel = UILabel()
        dateOfCreationLabel = UILabel()
        specialityStackView = UIStackView()
        scrollView = UIScrollView()
        contentView = UIView()
        
        super.init(nibName: nil, bundle: nil)
        
        nameLabel.text = item.name
        parseInformation(id: item.id)
    }
    
    private func confiqureSubviews() {
        backButton.titleLabel?.textAlignment = .center
        backButton.setTitleColor(.black, for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        nameLabel.numberOfLines = 0
        
        specialityStackView.spacing = 20
        specialityStackView.distribution = .equalSpacing
        specialityStackView.axis = .vertical
        
        descriptionLabel.numberOfLines = 0
        
        backButton.addTargetClosure {  [weak self] _ in
            self?.dismiss(animated: true)
        }
    }
    
    private func addSubviews() {
        contentView.addSubview(backButton)
        contentView.addSubview(logoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(headlaLabel)
        contentView.addSubview(dateOfCreationLabel)
        contentView.addSubview(specialityStackView)
        
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
    
    private func confiqureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.bottom.left.right.equalTo(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.bottom.equalTo(specialityStackView).offset(30)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.left.equalTo(contentView)
            make.height.equalTo(40)
            make.width.equalTo(60)
        }
        backButton.titleLabel?.snp.makeConstraints { make in
            make.left.equalTo(backButton).offset(20)
            make.centerY.equalTo(backButton)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.right.equalTo(contentView).offset(-20)
            make.width.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(logoImageView.snp.left).offset(-20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
        }
        
        headlaLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.left.equalTo(contentView).offset(20)
        }
        
        specialityStackView.snp.makeConstraints { make in
            make.top.equalTo(headlaLabel.snp.bottom).offset(20)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        confiqureSubviews()
        addSubviews()
        confiqureConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func parseInformation(id: Int) {
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "Faculties", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
            if let info = myDict?.value(forKey: "\(id)") as? [String: AnyObject],
                var specialities = info["specialities"] as? [String],
                let description =  info["description"] as? String,
                let head = info["head"] as? String {
                descriptionLabel.text = description
                headlaLabel.text = "Декан: " + head
                
                specialities = specialities.reversed()
                specialities.append("Специальности:")
                addSpecialities(specialities: specialities.reversed())
            } else {
            showAlert(withTitle: nil,
                      withText: "Нет данных",
                      completionBlock: {[weak self] _ in self?.dismiss(animated: true)})
            }
        }
    }

    private func addSpecialities(specialities: [String]) {
        for (index,item) in specialities.enumerated() {
            let label = UILabel()
            label.text = item
            if index == 0 {
                label.font = UIFont.boldSystemFont(ofSize: 20)
            }
            label.numberOfLines = 2
            specialityStackView.addArrangedSubview(label)
        }
    }
    
}
