

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    let manager = TrackerManager.shared
    
    func getPersonByIndex(indexPath: IndexPath) {
        if let person = manager.getPerson(indexPath: indexPath) {
            title.text = "ID: \(String(describing: person.id)) - \(String(describing: person.sername)) \(String(describing: person.name))"
        }
    }
}
