
import UIKit

class PersonTableViewCell: UITableViewCell {
    
    let manager = TrackerManager.shared
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func getPersonByIndex(section: Int, indexPath: IndexPath) {
        let workDay =  manager.getPerson(section: section, indexPath: indexPath)
        
        title.text = workDay.startWork.description
    }
    
    
}
