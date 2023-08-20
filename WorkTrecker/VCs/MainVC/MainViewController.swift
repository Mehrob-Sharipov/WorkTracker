

import UIKit

class MainViewController: UIViewController, RegistrationViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        reloadData()
    }
    
    
    func reloadData() {
        TrackerManager.shared.loadPersons()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    
    func showRegistrationVC(){
        guard let controller = storyboard?.instantiateViewController(identifier: "RegistrationViewController") as? RegistrationViewController else {return}
        controller.delegate = self
        present(controller, animated: true)
    }
    
    
    @IBAction func addPersonButton(_ sender: Any) {
        showRegistrationVC()
    }
    
    
    
    @IBAction func editButtonPressed(_ sender: Any) {
        tableView.isEditing.toggle()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TrackerManager.shared.countPerson()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell else {return UITableViewCell()}
        
        cell.getPersonByIndex(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TrackerManager.shared.selectedIndexPath = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        TrackerManager.shared.deletePerson(indexPath: indexPath)
        tableView.deleteRows(at: [indexPath], with: .left)
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        TrackerManager.shared.movePerson(sourceIndexPath: sourceIndexPath, destinationIndexPath: destinationIndexPath)
    }
}
