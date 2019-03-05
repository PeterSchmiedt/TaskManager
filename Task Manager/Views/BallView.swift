//
//  BallView.swift
//  Task Manager

import Foundation
import UIKit

@IBDesignable
class BallView : UIView {
    @IBInspectable var color: UIColor = .black {
        didSet {
            //setNeedsDisplay()
            setNeedsLayout() //marks the view as dirty
        }
    }
    
//    override func draw(_ rect: CGRect) {
//        let center = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0);
//
//        guard let ctx = UIGraphicsGetCurrentContext() else { return }
//        ctx.beginPath()
//
//        ctx.setFillColor(color.cgColor)
//
//        let x:CGFloat = center.x
//        let y:CGFloat = center.y
//
//        let radius: CGFloat = self.frame.size.width / 2.0
//        let endAngle: CGFloat = CGFloat(2 * Double.pi)
//
//        ctx.addArc(center: CGPoint(x: x, y: y), radius: radius, startAngle: 0, endAngle: endAngle, clockwise: true)
//
//
//        ctx.fillPath()
//    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.bounds.width/2
        self.clipsToBounds = true
        self.backgroundColor = color
    }
}
