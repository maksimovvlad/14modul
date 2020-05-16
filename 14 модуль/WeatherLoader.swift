import Foundation
import Alamofire

class WeatherLoader {
    
    func loadWeather5DayAlamofire (completion: @escaping (Weather, Weather) -> Void) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/forecast?q=Moscow&appid=8b05a42154abf4506ef436004688d289").responseJSON {
        response in
        if let objects = response.result.value,
        let jsonDict = objects as? NSDictionary {
                                            
        let datesJSONArray = jsonDict["list"] as! Array<NSDictionary>
        
//            var dates: [String] = []
            
        let dates = Weather()
            
        for weatherJSON in datesJSONArray {
            if let date = weatherJSON["dt_txt"] as? String
            {
                dates.date = date
            }
        }
                            
//        var temperatures: [Double] = []
            
            let temperatures = Weather()
                            
        for tempJSON in datesJSONArray {
            let main = tempJSON["main"] as! NSDictionary
            let temperature = main["temp"] as! Double
//                temperatures.append(temperature - 273)
            temperatures.nowTemperature = Int(temperature)
        }
        DispatchQueue.main.async {
            completion(dates, temperatures)
        }
        }
        }
    }
    
}
