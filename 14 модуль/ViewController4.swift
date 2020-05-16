import UIKit
import RealmSwift
import Alamofire

class ViewController4: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var weatherRealm: Results<Weather>!
    
    var weather: [Weather] = []
   
    var isRealm = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isRealm = true
        loadWeather5DayAlamofire() { weather in
        self.weatherRealm = self.realm.objects(Weather.self)
        self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isRealm = false
        loadWeather5DayAlamofire { weather in
        self.weather = weather
        self.tableView.reloadData()
        }
    }

    
    func loadWeather5DayAlamofire (completion: @escaping ([Weather]) -> Void) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/forecast?q=Moscow&appid=8b05a42154abf4506ef436004688d289").responseJSON {
        response in
        if let objects = response.result.value,
        let jsonDict = objects as? NSDictionary {
                                            
        let datesJSONArray = jsonDict["list"] as! Array<NSDictionary>
                
        var weathers: [Weather] = []
                            
        for tempJSON in datesJSONArray {
            let weather = Weather()
            let main = tempJSON["main"] as! NSDictionary
            let temperature = main["temp"] as! Double
            weather.nowTemperature = Int(temperature - 273)
                
            if let date = tempJSON["dt_txt"] as? String
            {
                weather.date = date
            }
            
            weathers.append(weather)
        }
                
            print(weathers)
                
        DispatchQueue.main.async {
                
            try! self.realm.write {
            self.realm.add(weathers)
            }
            
            completion(weathers)
        }
        }
        }
    }
    
}

extension ViewController4: UITableViewDataSource {

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isRealm { return weatherRealm?.count ?? 0}
    else { return weather.count }
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell2") as! WeatherCell2

    if isRealm {
    let weathers = weatherRealm[indexPath.row]
    cell.dateLable.text = weathers.date
    cell.degreeLabel.text = "\(Int((round(Double(weathers.nowTemperature))))) °C"
    } else {
        let weathers = weather[indexPath.row]
        cell.dateLable.text = weathers.date
        cell.degreeLabel.text = "\(Int((round(Double(weathers.nowTemperature))))) °C"
    }
    

    return cell
}
}
