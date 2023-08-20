 
import UIKit

class InformationViewController: UIViewController {
    
    
    @IBOutlet weak var yaerLable: UILabel!
    @IBOutlet weak var monthsLable: UILabel!
    @IBOutlet weak var daysLable: UILabel!
    @IBOutlet weak var hoursLable: UILabel!
    @IBOutlet weak var minutesLable: UILabel!
    
  
    func configLables(indexPath: IndexPath){
        
        TrackerManager.shared.getTimeStatus(indexPath: indexPath) { result in
            DispatchQueue.global().async {
                guard let year = result.year else {return}
                guard let month = result.month else {return}
                guard let day = result.day else {return}
                guard let hour = result.hour else {return}
                guard let second = result.second else {return}
                
                DispatchQueue.main.async {
                    self.monthsLable.text = "month: " + month.description
                    self.yaerLable.text = "year: " + year.description
                    self.daysLable.text = "day: " + day.description
                    self.hoursLable.text = "hour: " + hour.description
                    self.minutesLable.text = "second: " + second.description
                }
            }
        }
    }
}
