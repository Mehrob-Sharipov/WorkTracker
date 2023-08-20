import Foundation


class Person: Codable {
    let name: String
    let sername: String
    let id: Int
    let dateOfRegistration:String
    var workDay: [WorkDay]
    
    init(name: String, sername: String, id: Int, DateOfRegistration: String, workDay: [WorkDay]) {
        self.name = name
        self.sername = sername
        self.id = id
        self.dateOfRegistration = DateOfRegistration
        self.workDay = workDay
    }
    
    
    public enum CodingKeys: String, CodingKey {
        case name, sername, id, dateOfRegistration, workDay
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.sername = try container.decode(String.self, forKey: .sername)
        self.id = try container.decode(Int.self, forKey: .id)
        self.dateOfRegistration = try container.decode(String.self, forKey: .dateOfRegistration)
        self.workDay = try container.decode([WorkDay].self, forKey: .workDay)
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.name, forKey: .name)
        try container.encode(self.sername, forKey: .sername)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.dateOfRegistration, forKey: .dateOfRegistration)
        try container.encode (self.workDay, forKey: .workDay)
    }
} 

class WorkDay: Codable {
    var startWork: String
    var endWork: String?
    var done: Bool
    
    init(startWork: String, endWork: String? = nil, done: Bool) {
        self.startWork = startWork
        self.endWork = endWork
        self.done = done
    }
}


