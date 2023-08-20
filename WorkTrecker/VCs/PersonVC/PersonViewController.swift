 
import UIKit

class PersonViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        TrackerManager.shared.loadPersons()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
     }
    
    func showVC(indexPath: IndexPath){
        guard let controller = storyboard?.instantiateViewController(identifier: "InformationViewController") as? InformationViewController else {return}
        
        controller.configLables(indexPath: indexPath)
        present(controller, animated: true)
    }
    
    
    
    
    
    @IBAction func stopDayButtonPressed(_ sender: Any) {
        TrackerManager.shared.work(type: .stop)
        TrackerManager.shared.savePersons()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func startDayButtonPressed(_ sender: Any) {
        TrackerManager.shared.work(type: .start)
        TrackerManager.shared.savePersons()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
  
    
}

extension PersonViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TrackerManager.shared.getWorkDay(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PersonTableViewCell else {return UITableViewCell()}
        
        cell.getPersonByIndex(section: indexPath.section, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "In progress"
        case 1: return "Done job"
        default: return ""
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            tableView.reloadData()
            showVC(indexPath: indexPath)
        }
    }
    
    
}
