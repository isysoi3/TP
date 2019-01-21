//
//  ViewController.swift
//  Paint
//
//  Created by Ilya Sysoi on 4/14/18.
//  Copyright © 2018 Ilya Sysoi. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var canvasView: PaintView!
    private var resetButton: UIButton!
    private var settingsButtom: UIButton!
    private var saveButton: UIButton!
    private var border: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initUIAndConfigure()
        addSubviews()
        confiqureConstraints()
    }
    
    private func initUIAndConfigure() {
        view.backgroundColor = .white
        
        canvasView = PaintView()
        resetButton = UIButton(type: .system)
        settingsButtom = UIButton(type: .system)
        saveButton = UIButton(type: .system)
        
        resetButton.setTitle("reset", for: .normal)
        resetButton.addTarget(self, action: #selector(clearPaintView), for: .touchUpInside)
        
        settingsButtom.setTitle("settings", for: .normal)
        settingsButtom.addTarget(self, action: #selector(chnageDrawingColor), for: .touchUpInside)
        
        saveButton.setTitle("save", for: .normal)
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        border = UILabel()
        border.backgroundColor = .lightGray
    }

    private func addSubviews() {
        view.addSubview(border)
        view.addSubview(resetButton)
        view.addSubview(settingsButtom)
        view.addSubview(saveButton)
        view.addSubview(canvasView)
    }
    
    private func confiqureConstraints() {
        resetButton.snp.makeConstraints { make in
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(10)
            make.left.equalTo(view).offset(20)
        }
        
        settingsButtom.snp.makeConstraints { make in
            make.top.equalTo(resetButton)
            make.right.equalTo(view).offset(-20)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(resetButton)
            make.centerX.equalTo(view)
        }
        
        border.snp.makeConstraints { make in
            make.top.equalTo(resetButton.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(1)
        }
        
        canvasView.snp.makeConstraints { make in
            make.top.equalTo(border.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
        
       
    }
    
    @objc private func chnageDrawingColor() {
        let settings = SettingsViewController(
            initialColor: canvasView.drawingColor,
            initialWitdh: canvasView.brushWidth) { [weak self] color, brushWidth in
                self?.canvasView.chnageDrawingColorTo(color)
                self?.canvasView.chnageBrushWidth(brushWidth)
        }
        present(settings, animated: true)
    }
    
    @objc private func clearPaintView() {
        canvasView.resetView()
    }
    
    @objc private func save() {
        let image = canvasView.getImageToSave()
        let photoActivity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(photoActivity, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

