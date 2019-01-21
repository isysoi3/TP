//
//  ViewController.swift
//  lab7
//
//  Created by Ilya Sysoi on 10.04.2018.
//  Copyright © 2018 Ilya Sysoi. All rights reserved.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {

    //MARK: - properties
    private var ageLabel: UILabel!
    private var ageTextField: UITextField!
    
    private var heightLabel: UILabel!
    private var heightTextField: UITextField!
    
    private var weightLabel: UILabel!
    private var weightTextField: UITextField!
    
    private var genderLabel: UILabel!
    private var genderSegmentedControl: UISegmentedControl!
    
    private var traningsInWeekLabel: UILabel!
    private var traningsInWeekSegmentedControll: UISegmentedControl!
    
    private var calculateButton: UIButton!
    
    private var resultLabel: UILabel!
    
    private var coef = [1.2, 1.375, 1.55, 1.725]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        initAndConfigureUI()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func initAndConfigureUI() {
        ageLabel = UILabel()
        ageTextField = UITextField()
        
        heightLabel = UILabel()
        heightTextField = UITextField()
        
        weightLabel = UILabel()
        weightTextField = UITextField()
        
        genderLabel = UILabel()
        genderSegmentedControl = UISegmentedControl(items: ["Мужчина", "Женщина"])
        
        traningsInWeekLabel = UILabel()
        traningsInWeekSegmentedControll = UISegmentedControl(items: ["0", "1-3", "3-5", "6-7"])
        
        calculateButton = UIButton(type: .system)
        
        resultLabel = UILabel()
        
        confiugureChildViews()
        addSubviews()
        confiugureConstraints()
    }
    
    private func confiugureChildViews() {
        confiugureLabel(ageLabel, withText: "Возраст")
        confiugureTextField(ageTextField)
        
        confiugureLabel(heightLabel, withText: "Рост")
        confiugureTextField(heightTextField)
        
        confiugureLabel(weightLabel, withText: "Вес")
        confiugureTextField(weightTextField)
        
        confiugureLabel(genderLabel, withText: "Пол")
    
        confiugureLabel(traningsInWeekLabel, withText: "Тренеровок в неделю")
        traningsInWeekLabel.numberOfLines = 0
        traningsInWeekLabel.lineBreakMode = .byWordWrapping
        
        calculateButton.setTitle("Рассчитать", for: .normal)
        calculateButton.titleLabel?.textAlignment = .center
        calculateButton.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
        
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
    }
    
    private func confiugureLabel(_ label: UILabel, withText text: String) {
        label.text = text
    }
    
    private func confiugureTextField(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 3
        textField.keyboardType = .numberPad
        textField.addLeftOffsetToTextField(left: 10)
    }
    
    private func addSubviews() {
        view.addSubview(ageLabel)
        view.addSubview(ageTextField)
        
        view.addSubview(heightLabel)
        view.addSubview(heightTextField)
        
        view.addSubview(weightLabel)
        view.addSubview(weightTextField)
        
        view.addSubview(genderLabel)
        view.addSubview(genderSegmentedControl)
        
        view.addSubview(traningsInWeekLabel)
        view.addSubview(traningsInWeekSegmentedControll)
        
        view.addSubview(calculateButton)
        view.addSubview(resultLabel)
    }
    
    private func confiugureConstraints() {
        ageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(15)
            make.left.equalTo(view).offset(15)
            make.width.equalTo(100)
        }
        ageTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(ageLabel)
            make.left.equalTo(ageLabel.snp.right).offset(10)
            make.right.equalTo(view).offset(-15)
            make.height.equalTo(30)
        }
        
        heightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ageTextField.snp.bottom).offset(15)
            make.left.width.equalTo(ageLabel)
        }
        heightTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(heightLabel)
            make.left.right.height.equalTo(ageTextField)
        }

        weightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(heightTextField.snp.bottom).offset(15)
            make.left.width.equalTo(ageLabel)
        }
        weightTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(weightLabel)
            make.left.right.height.equalTo(ageTextField)
        }

        genderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weightTextField.snp.bottom).offset(15)
            make.left.width.equalTo(ageLabel)
        }
        genderSegmentedControl.snp.makeConstraints { (make) in
            make.centerY.equalTo(genderLabel)
            make.left.right.height.equalTo(ageTextField)
        }
        
        traningsInWeekLabel.snp.makeConstraints { (make) in
            make.top.equalTo(genderSegmentedControl.snp.bottom).offset(15)
            make.left.width.equalTo(ageLabel)
        }
        traningsInWeekSegmentedControll.snp.makeConstraints { (make) in
            make.centerY.equalTo(traningsInWeekLabel)
            make.left.right.height.equalTo(ageTextField)
        }
        
        calculateButton.snp.makeConstraints { (make) in
            make.top.equalTo(traningsInWeekSegmentedControll.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(100)
        }
        
        resultLabel.snp.makeConstraints { (make) in
            make.top.equalTo(calculateButton.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(200)
        }
    }
    
    @objc private func calculateButtonTapped() {
        if let weightString = weightTextField.text,
            weightString != "" ,
            let ageString = ageTextField.text,
            ageString != "",
            let heightString = heightTextField.text,
            heightString != "",
            genderSegmentedControl.selectedSegmentIndex != -1,
            traningsInWeekSegmentedControll.selectedSegmentIndex != -1 {
            if let weight = Double(weightString),
                let age = Double(ageString),
                let height = Double(heightString) {
                let bmi = weight/((height/100)*(height/100))
                let gender = genderSegmentedControl.selectedSegmentIndex
                let traningsCoefNumber = traningsInWeekSegmentedControll.selectedSegmentIndex
                var bmr = gender == 0 ? 88.362 : 447.593
                bmr += ((gender == 0 ? 13.397 : 9.247) * weight)
                bmr += ((gender == 0 ? 4.799 : 3.098) * height)
                bmr -= ((gender == 0 ? 5.677 : 4.330) * age)
                print(traningsCoefNumber)
                bmr *= coef[traningsCoefNumber]
                let bmiToString = String(format: "%.3f", bmi)
                addTextToResultLabel(text: "Вы должны потреблять \(bmr) калорий для поддержания веса.\nИндекс массы тела \(bmiToString).")
            } else {
                showAlert(title: nil, text: "Заполните правильно поля")
            }
        } else {
            showAlert(title: nil, text: "Заполните все поля и выберите все")
        }
    }
    
    private func showAlert(title: String?, text: String?) {
        let alert = UIAlertController(title: title,
                                      message: text,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        present(alert, animated: true)
    }
    
    private func addTextToResultLabel(text: String) {
        resultLabel.text = text
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

