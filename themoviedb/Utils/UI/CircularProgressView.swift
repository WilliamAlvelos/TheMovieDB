//
//  CircularProgressView.swift
//  themoviedb
//
//  Created by William Alvelos on 21/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import UIKit

@IBDesignable
class CircularProgressView: UIView {
    
    // MARK:- Configurable values
    var strokeWidth : CGFloat = 8.0 {
        didSet {
            basePathLayer.lineWidth = strokeWidth
            circlePathLayer.lineWidth = strokeWidth
        }
    }
    
    override var tintColor : UIColor! {
        didSet {
            circlePathLayer.strokeColor = tintColor.cgColor
        }
    }
    
    var label : UILabel = UILabel()
    
    
    @IBInspectable var baseColor : UIColor = UIColor.clear {
        didSet {
            basePathLayer.strokeColor = baseColor.cgColor
        }
    }
    
    var progress: CGFloat {
        get {
            return circlePathLayer.strokeEnd
        }
        set {
            if (newValue > 10.0) {
                circlePathLayer.strokeEnd = 1.0
            } else if (newValue <= 0.0) {
                circlePathLayer.strokeEnd = 0.0
                self.isHidden = true
            } else {
                circlePathLayer.strokeEnd = newValue / 10.0
            }
            
            let animation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            animation.duration = 0.5
            animation.isRemovedOnCompletion = false
            animation.fillMode = kCAFillModeForwards
            animation.fromValue = 0
            animation.toValue = circlePathLayer.strokeEnd
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            circlePathLayer.add(animation, forKey: "drawCircleAnimation")
            
            label.text = "\(Int(newValue*10)) %"
        }
    }
    
    // MARK: Init
    private let basePathLayer = CAShapeLayer()
    private let circlePathLayer = CAShapeLayer()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configure()
    }
    
    
    // MARK: Internal
    private func configure() {
        
        basePathLayer.frame = bounds
        basePathLayer.lineWidth = strokeWidth
        basePathLayer.fillColor = UIColor.clear.cgColor
        basePathLayer.strokeColor = baseColor.cgColor
        basePathLayer.actions = ["strokeEnd": NSNull()]
        layer.addSublayer(basePathLayer)
        
        circlePathLayer.frame = bounds
        circlePathLayer.lineWidth = strokeWidth
        circlePathLayer.fillColor = UIColor.clear.cgColor
        circlePathLayer.strokeColor = tintColor.cgColor
        circlePathLayer.actions = ["strokeEnd": NSNull()]

        layer.addSublayer(circlePathLayer)
        
        label.frame = circleFrame()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textColor = tintColor
        
        self.addSubview(label)
        
        progress = 0
    }
    
    private func circleFrame() -> CGRect {
        // keep the circle inside the bounds
        let shorter = (bounds.width > bounds.height ? bounds.height : bounds.width) - strokeWidth
        var circleFrame = CGRect(x: 0, y: 0, width: shorter, height: shorter)
        circleFrame.origin.x = circlePathLayer.bounds.midX - circleFrame.midX
        circleFrame.origin.y = circlePathLayer.bounds.midX - circleFrame.midX
        return circleFrame
    }
    
    private func circlePath() -> UIBezierPath {
        return UIBezierPath(roundedRect: circleFrame(), byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: bounds.width, height: bounds.height))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        basePathLayer.frame = bounds
        basePathLayer.path = circlePath().cgPath
        circlePathLayer.frame = bounds
        circlePathLayer.path = circlePath().cgPath
    }
}
