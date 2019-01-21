//
//  SettingsViewController.swift
//  Paint
//
//  Created by Ilya Sysoi on 4/17/18.
//  Copyright © 2018 Ilya Sysoi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    typealias ColorAndWidthBrushBlock = (_ color: CGColor, _ brushWidth: CGFloat) -> ()
    private var cancelButton: UIButton
    private var sliderBrushWidth: UISlider
    private var sliderValueLabel: UILabel
    private var currentColor: CGColor
    private var initialColor: CGColor
    private var initialWitdh: CGFloat
    private var chooseButton: UIButton
    private var colorButtons: [UIButton]
    private var colorsView: UIStackView
    private var callbackBlock: ColorAndWidthBrushBlock
    private let avaliableColors: [UIColor] = [.black,
                                             .blue,
                                             .red,
                                             
                                             .green,
                                             .yellow,
                                             .purple,
                                             
                                             .brown,
                                             .gray,
                                             .orange]
    
    init(initialColor: CGColor,
         initialWitdh: CGFloat,
         callbackBlock: @escaping ColorAndWidthBrushBlock) {
        self.initialColor = initialColor
        self.initialWitdh = initialWitdh
        self.callbackBlock = callbackBlock
        self.currentColor = initialColor
        
        cancelButton = UIButton(type: .system)
        chooseButton = UIButton()
        sliderBrushWidth = UISlider()
        sliderValueLabel = UILabel()
        colorsView = UIStackView()
        colorButtons = []
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUIAndConfigure()
        addColors()
        addSubviews()
        confiqureConstraints()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    private func initUIAndConfigure() {
        
        view.backgroundColor = .white
        
        cancelButton.setTitle("cancel", for: .normal)
        cancelButton.addTarget(self,
                               action: #selector(dismissViewController),
                               for: .touchUpInside)
        
        chooseButton.setTitle("Choose", for: .normal)
        chooseButton.addTarget(self,
                               action: #selector(chooseSettings),
                               for: .touchUpInside)
        
        chooseButton.setTitleColor(.white, for: .normal)
        chooseButton.backgroundColor = UIColor(cgColor: initialColor)
        chooseButton.layer.cornerRadius = 4
       
        sliderBrushWidth.maximumValue = 20
        sliderBrushWidth.minimumValue = 1
        sliderBrushWidth.setValue(Float(initialWitdh), animated: false)
        sliderBrushWidth.addTarget(self,
                                   action: #selector(sliderChanges),
                                   for: .valueChanged)
        
        sliderValueLabel.text = "\(initialWitdh)"
        
        
    }
    
    private func addColors() {
        colorsView.axis = .vertical
        colorsView.distribution = .equalSpacing
        colorsView.spacing = 20
        
        var verticalView = UIStackView()
        verticalView.axis = .horizontal
        verticalView.distribution = .equalSpacing
        for (index,color) in avaliableColors.enumerated() {
            if index != 0,
                index % 3 == 0 {
                colorsView.addArrangedSubview(verticalView)
                
                verticalView = UIStackView()
                verticalView.axis = .horizontal
                verticalView.distribution = .equalSpacing
            }
            let colorButton = configureColorButton(withColor: color,
                                                   selected: color.cgColor == initialColor)
            colorButtons.append(colorButton)
            verticalView.addArrangedSubview(colorButton)
        }
        colorsView.addArrangedSubview(verticalView)
    }
    
    private func configureColorButton(withColor color: UIColor,
                                      selected: Bool)  -> UIButton {
        let button = UIButton()
        button.backgroundColor = color
        button.addTarget(self,
                         action: #selector(getColor(_:)),
                         for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.0
        
        if selected {
            selectButton(button)
        }
        
        button.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        return button
    }
    
    
    private func selectButton(_ button: UIButton) {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.shadowOpacity = 1.0
    }
    
    private func resetSelectedColor() {
        colorButtons.forEach {
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.layer.borderWidth = 0
            $0.layer.shadowOpacity = 0
        }
    }
    
    private func addSubviews() {
        view.addSubview(cancelButton)
        view.addSubview(sliderBrushWidth)
        view.addSubview(sliderValueLabel)
        view.addSubview(chooseButton)
        view.addSubview(colorsView)
    }
    
    private func confiqureConstraints() {
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(10)
            make.right.equalTo(view).offset(-20)
        }
        
        sliderBrushWidth.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        sliderValueLabel.snp.makeConstraints { make in
            make.top.equalTo(sliderBrushWidth.snp.bottom).offset(10)
            make.centerX.equalTo(view)
        }
        
        colorsView.snp.makeConstraints { make in
            make.top.equalTo(sliderValueLabel.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        chooseButton.snp.makeConstraints { make in
            make.top.equalTo(colorsView.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(100)
        }
        
    }
    
    @objc private func getColor(_ sender: UIButton) {
        currentColor = (sender.backgroundColor?.cgColor)!
        chooseButton.backgroundColor = UIColor(cgColor: currentColor)
        resetSelectedColor()
        selectButton(sender)
    }
    
    @objc private func chooseSettings() {
        callbackBlock(currentColor, CGFloat(sliderBrushWidth.value))
        dismissViewController()
    }
    
    @objc private func sliderChanges() {
        let sliderValueString = String(format: "%.2f", sliderBrushWidth.value)
        sliderValueLabel.text = sliderValueString
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
}
