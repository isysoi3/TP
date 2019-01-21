//
//  PaintView.swift
//  Paint
//
//  Created by Ilya Sysoi on 4/14/18.
//  Copyright © 2018 Ilya Sysoi. All rights reserved.
//

import UIKit

class PaintView: UIImageView {

    private var lastPoint: CGPoint
    private(set) var drawingColor: CGColor
    private(set) var brushWidth: CGFloat
    private let linesAlpha: CGFloat
    
    init() {
        lastPoint = CGPoint.zero
        drawingColor = UIColor.black.cgColor
        brushWidth = 10
        linesAlpha = 1
        
        super.init(frame: .zero)
        clipsToBounds = true
        isMultipleTouchEnabled = false
        isUserInteractionEnabled = true
        
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            lastPoint = touch.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            handleTouche(touch)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            handleTouche(touch)
        }
    }
    
    private func handleTouche(_ touch: UITouch) {
        let currentPoint = touch.location(in: self)
        drawLine(fromPoint: lastPoint, toPoint: currentPoint)
        
        lastPoint = currentPoint
    }
    
    private func drawLine(fromPoint: CGPoint, toPoint: CGPoint) {
    
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            image?.draw(in: self.bounds)
            
            context.move(to: fromPoint)
            context.addLine(to: toPoint)
            
            context.setLineCap(.round)
            context.setLineWidth(brushWidth)
            context.setStrokeColor(drawingColor)
            context.setBlendMode(.normal)
            
            context.strokePath()
            
            image = UIGraphicsGetImageFromCurrentImageContext()
            alpha = linesAlpha
            UIGraphicsEndImageContext()
        }
    }
    
    func chnageBrushWidth(_ width: CGFloat) {
        brushWidth = width
    }
    
    
    func getImageToSave() -> UIImage? {
        UIGraphicsBeginImageContext(bounds.size)
        image?.draw(in: self.bounds)
        let paintings = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return paintings
    }
    
    func chnageDrawingColorTo(_ color: CGColor) {
        drawingColor = color
    }
    
    func resetView() {
        image = nil
        backgroundColor = .white
    }

}
