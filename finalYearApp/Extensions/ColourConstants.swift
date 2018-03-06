import Foundation
import UIKit

extension UIColor {
    
    static let coral = UIColor(red: 241, green: 101, blue: 80, alpha: 1.0)
    static let orange = UIColor(red: 223, green: 50, blue: 52, alpha: 1.0)
    static let red = UIColor(red: 2, green: 1, blue: 25, alpha: 1.0)
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
    
}
