//
//  extension.swift
//  FoodTracker
//
//  Created by Apple on 11/23/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class uiviewExtetion: UIView {
    @IBInspectable var borderColorfourside: UIColor = .clear {
        didSet {
        layer.borderColor = borderColorfourside.cgColor
        }
    }

    @IBInspectable var borderWidthfourside: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidthfourside
        }
    }

    @IBInspectable var cornerRadiusfourside: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadiusfourside
        }
    }
    

}

extension UITextField {
  func setBottomBorder() {
    self.borderStyle = .none
    self.layer.backgroundColor = UIColor.white.cgColor

    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    self.layer.shadowOpacity = 1.0
    self.layer.shadowRadius = 0.0
  }
}

extension UIView {
    func setbottomborder(){
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}





//@IBDesignable extension UIView {
//    @IBInspectable var borderColor:UIColor? {
//        set {
//            layer.borderColor = newValue!.cgColor
//        }
//        get {
//            if let color = layer.borderColor {
//                return UIColor(cgColor:color)
//            }
//            else {
//                return nil
//            }
//        }
//    }
//    @IBInspectable var borderWidth:CGFloat {
//        set {
//            layer.borderWidth = newValue
//        }
//        get {
//            return layer.borderWidth
//        }
//    }
//    @IBInspectable var cornerRadius:CGFloat {
//        set {
//            layer.cornerRadius = newValue
//            clipsToBounds = newValue > 0
//        }
//        get {
//            return layer.cornerRadius
//        }
//    }
//}
@IBDesignable
extension UIView {
    
@IBInspectable var cornerRadius: CGFloat {
    get {
        return layer.cornerRadius
    }
    set {
        layer.cornerRadius = newValue
        layer.masksToBounds = newValue > 0
    }
}

@IBInspectable var borderWidth: CGFloat {
    get {
        return layer.borderWidth
    }
    set {
        layer.borderWidth = newValue
    }
}

@IBInspectable var borderColor: UIColor? {
    get {
        return UIColor(cgColor: layer.borderColor!)
    }
    set {
        layer.borderColor = newValue?.cgColor
    }
}

@IBInspectable var leftBorderWidth: CGFloat {
    get {
        return 0.0   // Just to satisfy property
    }
    set {
        let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: newValue, height: bounds.height))
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(cgColor: layer.borderColor!)
       line.tag = 110
        self.addSubview(line)

        let views = ["line": line]
        let metrics = ["lineWidth": newValue]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
    }
}

@IBInspectable var topBorderWidth: CGFloat {
    get {
        return 0.0   // Just to satisfy property
    }
    set {
        let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: bounds.width, height: newValue))
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = borderColor
       line.tag = 110
        self.addSubview(line)

        let views = ["line": line]
        let metrics = ["lineWidth": newValue]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
    }
}

@IBInspectable var rightBorderWidth: CGFloat {
    get {
        return 0.0   // Just to satisfy property
    }
    set {
        let line = UIView(frame: CGRect(x: bounds.width, y: 0.0, width: newValue, height: bounds.height))
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = borderColor
       line.tag = 110
        self.addSubview(line)

        let views = ["line": line]
        let metrics = ["lineWidth": newValue]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
    }
}
@IBInspectable var bottomBorderWidth: CGFloat {
    get {
        return 0.0   // Just to satisfy property
    }
    set {
        let line = UIView(frame: CGRect(x: 0.0, y: bounds.height, width: bounds.width, height: newValue))
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = borderColor
      line.tag = 110
        self.addSubview(line)

        let views = ["line": line]
        let metrics = ["lineWidth": newValue]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
    }
}
 func removeborder() {
      for view in self.subviews {
           if view.tag == 110  {
                view.removeFromSuperview()
           }

      }
 }
}

