
import Foundation

enum InformationType {
    case byDay (indexPath: IndexPath)
    case allTime
}

enum WorkType {
    case stop
    case start
}


class TrackerManager {
    static let shared = TrackerManager()
    private var persons: [Person] = [] {
        didSet {
            savePersons()
        }
    }
    
    
    private var count = 0
    var selectedIndexPath = 0
    
    func getID() -> Int{
        count += 1
        return count
    }
    
    
    func savePersons(){
        UserDefaults.standard.setClass(encodable: persons, forKey: "person")
    }
    
    func loadPersons(){
        guard let person = UserDefaults.standard.valueClass([Person].self, forKey: "person") else {return}
        self.persons = person
    }
    
    
    
    func stringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    
    func getTimeStatus(indexPath:IndexPath, completion: @escaping (DateComponents) -> () ){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .current
        
        let startWork = persons[selectedIndexPath].workDay[indexPath.row].startWork
        let endWork = persons[selectedIndexPath].workDay[indexPath.row].endWork!
        
        if let startDate = dateFormatter.date(from: startWork), let  endDate = dateFormatter.date(from: endWork) {
            
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: startDate, to: endDate)
            completion(dateComponents)
        }
    }
    
    
    func work(type:WorkType){
        let date = stringFromDate(date: Date())
        
        switch type {
        case .stop:
            persons[selectedIndexPath].workDay.last?.done = true
            persons[selectedIndexPath].workDay.last?.endWork = date
        case .start:
            if  persons[selectedIndexPath].workDay.count != 0 {
                persons[selectedIndexPath].workDay.last?.done = true
                persons[selectedIndexPath].workDay.last?.endWork = date
            }
            let workDay = WorkDay(startWork: date, endWork: nil, done: false)
            persons[selectedIndexPath].workDay.append(workDay)
        }
    }
    
    
    func addPerson(person: Person) {
        persons.append(person)
    }
    
    
    func deletePerson(indexPath: IndexPath) {
        persons.remove(at: indexPath.row)
    }
    
    
    func movePerson(sourceIndexPath:IndexPath, destinationIndexPath:IndexPath){
        let person = persons.remove(at: sourceIndexPath.row)
        persons.insert(person, at: destinationIndexPath.row)
    }
    
    
    func getPerson(indexPath: IndexPath) -> Person? {
        return persons[safe: indexPath.row]
    }
    
    
    func getPerson(section: Int, indexPath: IndexPath) -> WorkDay {
        let workDays = persons[selectedIndexPath].workDay
        let trueDays = workDays.filter {$0.done == true}
        let falseDays = workDays.filter {$0.done == false}
        return section == 1 ? trueDays[indexPath.row] : falseDays[indexPath.row]
    }
    
    
    func getWorkDay(section: Int) -> Int {
        let workDays = persons[selectedIndexPath].workDay
        let trueDays =  workDays.filter {$0.done == true}.count
        let falseDays =  workDays.filter {$0.done == false}.count
        return section == 1 ? trueDays : falseDays
    }
    
    
    func countPerson() -> Int {
        return persons.count
    }
}






