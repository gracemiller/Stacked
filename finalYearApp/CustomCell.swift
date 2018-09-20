import UIKit

class CustomCell: UITableViewCell {
    
    var post: Post?
    private var bg = UIColor.red
  
    @IBOutlet weak var demo: UIView!
    @IBOutlet var screenShotImage: UIImageView!
    @IBOutlet var weightsLabel: UILabel!
    @IBOutlet var setsLabel: UILabel!
    @IBOutlet var repsLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var newPB: UIImageView!
    
    override func prepareForReuse() {
    super.prepareForReuse()
  }

  
}
