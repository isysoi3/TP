//
//  ViewController.swift
//  task_1
//
//  Created by Ilya Sysoi on 4/19/18.
//  Copyright © 2018 Ilya Sysoi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var flower: CAShapeLayer!
    private var trapeze: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        drawTrapeze()
        drawFlower()
    }
    
    @IBAction func swipe(_ sender: Any) {
        view.backgroundColor = .gray
        
    }

    @IBAction func rotation(_ sender: Any) {
        view.backgroundColor = .yellow
    }
    
    @IBAction func pinch(_ sender: Any) {
        view.backgroundColor = .green
    }
    
    @IBAction func tap(_ sender: Any) {
        view.backgroundColor = .black
    }
    
    @IBAction func longTap(_ sender: Any) {
        view.backgroundColor = .red
    }
    
    private func rundomPointOfFlower() -> CGPoint {
        let randomX = Int(70 + arc4random_uniform(UInt32(UIScreen.main.bounds.width - 70)))
        let randomY = Int(70 + arc4random_uniform(UInt32(UIScreen.main.bounds.height - 70)))
        return CGPoint(x: randomX, y: randomY)
    }
    
    @IBAction func move(_ sender: Any) {
        
        let moveAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
        moveAnimation.fromValue = flower.path
        flower.path = flowerPath(center: rundomPointOfFlower(), radius: CGFloat(50)).cgPath
        moveAnimation.toValue = flower.path
        moveAnimation.duration = 4
        
        flower.add(moveAnimation, forKey: nil)
    }
    
    @IBAction func rotate(_ sender: Any) {
        let rotateAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        rotateAnimation.valueFunction = CAValueFunction(name: kCAValueFunctionRotateZ)
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = 2 * Double.pi
        rotateAnimation.duration = 4
        
        flower.add(rotateAnimation, forKey: nil)
    }
    
    @IBAction func scale(_ sender: Any) {
        let scaleAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        scaleAnimation.valueFunction = CAValueFunction(name: kCAValueFunctionScale)
        scaleAnimation.fromValue = [1,1,0]
        scaleAnimation.toValue = [2,2,0]
        scaleAnimation.duration = 2
        
        flower.add(scaleAnimation, forKey: nil)
    }
    
    @IBAction func bleach(_ sender: Any) {
        let bleachAnimation = CABasicAnimation(keyPath: "opacity")
        bleachAnimation.fromValue = 1
        bleachAnimation.toValue = 0
        bleachAnimation.duration = 4
        
        flower.add(bleachAnimation, forKey: nil)
    }
    
    @IBAction func twoActions(_ sender: Any) {
        let bleachAnimation = CABasicAnimation(keyPath: "opacity")
        bleachAnimation.fromValue = 1
        bleachAnimation.toValue = 0
    
        
        
        let scaleAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        scaleAnimation.valueFunction = CAValueFunction(name: kCAValueFunctionScale)
        scaleAnimation.fromValue = [1,1,0]
        scaleAnimation.toValue = [1.5,1.5,0]
        
        
        let groupAnimations = CAAnimationGroup()
        groupAnimations.animations = [bleachAnimation, scaleAnimation]
        groupAnimations.duration = 3
        flower.add(groupAnimations, forKey: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func trapezePath(start: CGPoint,
                               averageLine: CGFloat,
                               height: CGFloat) -> UIBezierPath {
        let brush = UIBezierPath()
        
        brush.move(to: start)
        brush.addLine(to: CGPoint(x:start.x + 1.2*averageLine,
                                  y: start.y))
        brush.addLine(to: CGPoint(x:start.x + 1.1*averageLine,
                                  y: start.y + height))
        brush.addLine(to: CGPoint(x: start.x + 0.1*averageLine,
                                  y: start.y + height))

        brush.close()
        
        return brush
    }
    
    private func flowerPath(center: CGPoint,
                      radius: CGFloat) -> UIBezierPath {
        let brush = UIBezierPath()
        
        let r = radius * 1.17557 / 2
        
        brush.addArc(withCenter: CGPoint(x: center.x, y: center.y - radius),
                     radius: r,
                     startAngle: CGFloat(144/180*Double.pi),
                     endAngle: CGFloat(0.2*Double.pi),
                     clockwise: true)
        
        brush.addArc(withCenter: CGPoint(x:center.x + CGFloat(cos(Double.pi*0.1))*radius,
                                         y:center.y - CGFloat(sin(Double.pi*0.1))*radius),
                     radius: r,
                     startAngle: CGFloat(216/180*Double.pi),
                     endAngle: CGFloat(108/180*Double.pi),
                     clockwise: true)
        
        brush.addArc(withCenter: CGPoint(x:center.x + CGFloat(cos(54/180*Double.pi))*radius,
                                         y:center.y + radius*CGFloat(sin(54/180*Double.pi))),
                     radius: r,
                     startAngle: -CGFloat(72/180*Double.pi),
                     endAngle: CGFloat(Double.pi),
                     clockwise: true)
        
        brush.addArc(withCenter: CGPoint(x: center.x - CGFloat(cos(54/180*Double.pi))*radius,
                                         y: center.y + CGFloat(sin(54/180*Double.pi))*radius),
                     radius: r,
                     startAngle: 0,
                     endAngle: CGFloat(252/180*Double.pi),
                     clockwise: true)
        
        brush.addArc(withCenter: CGPoint(x:center.x - CGFloat(cos(Double.pi*0.1))*radius,
                                         y:center.y - CGFloat(sin(Double.pi*0.1))*radius),
                     radius: r,
                     startAngle: CGFloat(72/180*Double.pi),
                     endAngle: -CGFloat(36/180*Double.pi),
                     clockwise: true)
        
        return brush
    }

    private func drawFlower() {
        flower = CAShapeLayer()
        let path = flowerPath(center: CGPoint(x: 100, y: 200),
                              radius: 50)
        flower.path = path.cgPath
        flower.fillColor = UIColor.red.cgColor
        flower.shadowRadius = 4
        flower.shadowOpacity = 0.4
        flower.frame = path.bounds
        view.layer.addSublayer(flower)
        
    }
    
    private func drawTrapeze() {
        trapeze = CAShapeLayer()
        
        let path = trapezePath(start: CGPoint(x: 100, y: 100),
                                averageLine: 150,
                                height: 100)
        
        trapeze.path = path.cgPath
        
        trapeze.fillColor = UIColor.green.cgColor
        trapeze.shadowRadius = 4
        trapeze.shadowOpacity = 0.4
        trapeze.frame = view.bounds
        view.layer.addSublayer(trapeze)
        
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        gradient.mask = trapeze
        view.layer.addSublayer(gradient)
        
    }


}

