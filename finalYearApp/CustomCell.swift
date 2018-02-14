import UIKit

class CustomCell: UITableViewCell {
  
  private var bg = UIColor.red
  
    @IBOutlet weak var demo: UIView!
    @IBOutlet var screenShotImage: UIImageView!
    @IBOutlet var exerciseLabel: UILabel!
    @IBOutlet var weightsLabel: UILabel!
    @IBOutlet var setsLabel: UILabel!
    @IBOutlet var repsLabel: UILabel!
    
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  
}
