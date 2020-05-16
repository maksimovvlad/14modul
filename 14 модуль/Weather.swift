import Foundation
import RealmSwift

class Weather: Object {

    @objc dynamic var nowTemperature: Int = 0
    @objc dynamic var date: String = ""

    convenience init?(data: NSDictionary) {
        guard let nowTemperature = data["temp"] as? Double else {  return nil  }
        self.init()

        self.nowTemperature = Int((round(nowTemperature) - 273))
        self.date = ""
    }
}

