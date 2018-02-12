import Foundation
import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var screenshotImage: UIImageView!
    @IBOutlet var exerciseLabel: UILabel!
    @IBOutlet var weightsLabel: UILabel!
    @IBOutlet var repsLabel: UILabel!
    @IBOutlet var setsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
