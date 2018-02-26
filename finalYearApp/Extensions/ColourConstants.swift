import Foundation
import UIKit




extension UIColor {
    
    static let coral = UIColor(red: 242, green: 103, blue: 80)
    static let orange = UIColor(red: 225, green: 25, blue: 33, alpha: 1.0)
    static let red = UIColor(red: 239, green: 84, blue: 70, alpha: 1.0)
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
    
}
