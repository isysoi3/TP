//
//  ViewController.swift
//  Simple Project to switch image
//
//  Created by Ilya Sysoi on 10.04.2018.
//  Copyright © 2018 Ilya Sysoi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundSwitch: UISwitch!
    
    @IBOutlet weak var switchIndicator: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchIndicator.textColor = .white
        switchIndicator.text = "Background image: bg2.jpg"
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg2")!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backgroundSwitchTapped(_ sender: Any) {
        if backgroundSwitch.isOn {
            switchIndicator.text = "Background image: bg1.jpg"
            view.backgroundColor = UIColor(patternImage: UIImage(named: "bg1")!)
        } else {
            switchIndicator.text = "Background image: bg2.jpg"
            view.backgroundColor = UIColor(patternImage: UIImage(named: "bg2")!)
        }
    }
    
}

