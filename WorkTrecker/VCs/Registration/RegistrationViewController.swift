
import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var sernameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: RegistrationViewControllerDelegate?
    
    private var responder: Bool = true {
        didSet {
            if responder {
                sernameTextField.resignFirstResponder()
            } else {
                sernameTextField.becomeFirstResponder()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
        datePicker.maximumDate = Date.now
    }
    
    
    
    func saveToManager(){
        let name = nameTextfield.text ?? ""
        let sername = sernameTextField.text ?? ""
        let date = TrackerManager.shared.stringFromDate(date: datePicker.date)
        let id = TrackerManager.shared.getID()
        let person = Person(name: name, sername: sername, id: id, DateOfRegistration: date, workDay: .init())
        TrackerManager.shared.addPerson(person: person)
    }
    
    
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        saveToManager()
        delegate?.reloadData()
        dismiss(animated: true)
    }
}


extension RegistrationViewController : UITextFieldDelegate {
    
    func setTextField(){
        nameTextfield.delegate = self
        sernameTextField.delegate = self
        nameTextfield.becomeFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch responder {
        case true:
            responder = false
            nameTextfield.resignFirstResponder()
        case false:
            responder = true
        }
        return true
    }
}


