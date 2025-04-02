import UIKit

extension UIView {
        @IBInspectable var cornerRadius:CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable var Round:Bool {
        set {
            self.layer.cornerRadius = self.frame.size.height / 2.0
            self.clipsToBounds = true
        }
        get {
            self.clipsToBounds = true
            return self.layer.cornerRadius == self.frame.size.height / 2.0
        }
    }
    
    @IBInspectable var borderColor:UIColor {
        set {
            self.layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
    }
    
    @IBInspectable var borderWidth:CGFloat {
        set {
            self.layer.borderWidth = newValue
        }
        get {
            return self.layer.borderWidth
        }
    }
}

