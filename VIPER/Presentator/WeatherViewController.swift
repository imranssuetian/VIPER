//
//  ViewController.swift
//  VIPER
//
//  Created by Imran Shah on 22/07/2019.
//  Copyright © 2019 Imran Shah. All rights reserved.
//

import UIKit
import OpenWeatherKit

class WeatherViewController: UIViewController {

    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var temprature: UILabel!
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var wetaher: UICollectionView!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //for hours
    var time = ["Now","2 AM","3 AM","4 AM","5 AM","6 AM","7 AM"]
    var temp = [31.0,32.1,32.1,32.1,32.1,32.1,32.1]
    var image = ["clear-day","clear-night","dark-sky-logo","fog","partly-cloudy-day","partly-cloudy-night","rain"] //sleet snow wind
    var dt_Array = [Double]()
    var temp_Array = [Double]()
    var weatherNameArray = [String]()
    var today: String = ""
    var day: String = ""
    var minimumTemp: Double = 0
    var maximumTemp: Double = 0
    
    //for days
    var days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    var daysImage = ["clear-day","clear-night","dark-sky-logo","fog","partly-cloudy-day","partly-cloudy-night","rain"] //sleet snow wind
    var lowestTemp = [31.0,32.1,32.1,32.1,32.1,32.1,32.1]
    var highestTemp = [31.0,32.1,32.1,32.1,32.1,32.1,32.1]
    var lowest_temp_array = [Double]()
    var highest_temp_array = [Double]()
    
    var mondayCount: Int = 0
    var tuesdayCount: Int = 0
    var wednesdayCount: Int = 0
    var thursdayCount: Int = 0
    var fridayCount: Int = 0
    var saturdayCount: Int = 0
    var sundayCount: Int = 0
    
    //enum days
    enum Day : String {
        case Monday
        case Tuesday
        case Wednesday
        case Thursday
        case Friday
        case Saturday
        case Sunday

    }
   
    
    //enum weather
    enum Weather : String {
        
        case Rain
        case Snow
        case Clouds
        case Clear
        case Fog
        case Sun
        case Wind
        
    }
    
    //details
    var humidity:Double = 0
    var pressure:Double = 0
    
    var sea_level:Double = 0
    var ground_level:Double = 0
    
    var wind_speed:Double = 0
    var wind_direction:Double = 0
    
    var cloudiness:Double = 0
    var precipitation:Double = 0
    
    var temprature_description: String = "Today: Partly cloudy condtions with a heat index of 41° and 26 km/hr winds from the south-west."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Hello world")
        searchView.layer.cornerRadius = 10
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search By City",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])

//        let API_KEY:String = "39d3df86cda45bf4394dbeb18fa015d9"
//        let weatherApi = WeatherApi(key: API_KEY)
//
//        weatherApi.getWeatherFor(cityId: 1275339) { (result) in
//            switch result {
//            case .success(let weather):
//
//                //                self.cityLabel.text = weather.name
//                //                self.tempLabel.text = "\(weather.main.temp)"
//
//                print(weather.name)
//                print(weather.clouds)
//
//
//            case .error(_):
//                //Do something
//                break
//            }
        
//        }
        
//        weatherApi.getWeatherFor(lat: "5.567788", lon: "1.5544") { result in
//            switch result {
//            case .success(let weather):
//
////                self.cityLabel.text = weather.name
////                self.tempLabel.text = "\(weather.main.temp)"
//
//                print(weather.name)
//                print(weather.clouds)
//
//            case .error(_):
//                //Do something
//                break
//            }
//        }
        
        //backgroundImage.image = UIImage.gif(url: Constants.sleet)

        setupTableView()
        
        let base_url = "http://api.openweathermap.org/data/2.5/forecast?id="
        let city_id = "1174872"
        let mics = "&APPID="
        let api_key = "39d3df86cda45bf4394dbeb18fa015d9"
        
//        let urlString = "http://api.openweathermap.org/data/2.5/forecast?id=1275339&APPID=39d3df86cda45bf4394dbeb18fa015d9"
        let urlString = base_url + city_id + mics + api_key

//        APIRouter.urlRequest(modelType: WeatherInfo.self, urlString: urlString)
    
        urlRequest(urlString: urlString)
        
        




    }
    
    @IBAction func didTappedSearchField(_ sender: UITextField) {
        
        print("did tapped")
        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = rootVC

        
    }
    
    func setLowHighTemp(index: Int){
        
        let lowest_tempInK: Double = self.lowest_temp_array[index]
        let lowest_tempInC: Double = lowest_tempInK - Constants.kelvin
        
        self.lowestTemp.append(lowest_tempInC)
        
        let highest_tempInK: Double = self.highest_temp_array[index]
        let highest_tempInC: Double = highest_tempInK - Constants.kelvin
        
        self.highestTemp.append(highest_tempInC)
    }
    
    func setBackgroundImage(weather: Weather){
        
        switch weather {
            
        case .Clear:
            
            backgroundImage.image = UIImage.gif(url: Constants.clear_day)

            
        case .Rain:
            
            backgroundImage.image = UIImage.gif(url: Constants.blueClouds)
            UIApplication.shared.statusBarStyle = .lightContent

            
        case .Snow:
            
            backgroundImage.image = UIImage.gif(url: Constants.snow)
            
        case .Clouds:
            
            backgroundImage.image = UIImage.gif(url: Constants.blueClouds)
            UIApplication.shared.statusBarStyle = .lightContent

        case .Fog:
            
            backgroundImage.image = UIImage.gif(url: Constants.fog)
            UIApplication.shared.statusBarStyle = .lightContent

            
        case .Sun:
            
            backgroundImage.image = UIImage.gif(url: Constants.sun)

            
        case .Wind:
            
            backgroundImage.image = UIImage.gif(url: Constants.wind)

        }
        
    }
    
    
    
    func urlRequest(urlString: String) {
        
        //        let jsonUrlString = "http://api.openweathermap.org/data/2.5/forecast?id=1275339&APPID=39d3df86cda45bf4394dbeb18fa015d9"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //perhaps check err
            //also perhaps check response status 200 OK
            
            guard let data = data else { return }
            
            //            let dataAsString = String(data: data, encoding: .utf8)
            //            print(dataAsString)
            
            do {
                
                let myStruct = try JSONDecoder().decode(WeatherByID.self, from: data)
       
                let cityName : String = myStruct.city.name!
                let weatherStatus : String = myStruct.list[0].weather[0].main!
                let weatherDescription: String = myStruct.list[0].weather[0].description!
                self.temprature_description = weatherDescription
                let mainTempinK: Double = myStruct.list[0].main.temp!
                let mainTempinC: Double = mainTempinK - Constants.kelvin
                let mainTempinConverted: String = String(format: "%.f", mainTempinC)
                
                let maxTempinK: Double = myStruct.list[0].main.temp_max!
                let maxTempinC: Double = maxTempinK - Constants.kelvin

                let minTempinK: Double = myStruct.list[0].main.temp_min!
                let minTempinC: Double = minTempinK - Constants.kelvin
                
                self.humidity = myStruct.list[0].main.humidity!
                self.pressure = myStruct.list[0].main.pressure!
                self.sea_level = myStruct.list[0].main.sea_level!
                self.ground_level = myStruct.list[0].main.grnd_level!
                self.wind_speed = myStruct.list[0].wind.speed!
                self.wind_direction = myStruct.list[0].wind.deg!
                self.cloudiness = myStruct.list[0].clouds.all!
//                self.precipitation = myStruct.list[0].main.humidity!
                
                //for hours
                for i in 0...39 {
                    
                    let dt_value = myStruct.list[i].dt
                    self.dt_Array.append(Double(dt_value!))
                    
                    let temp_value = myStruct.list[i].main.temp
                    self.temp_Array.append(Double(temp_value!))
                    
                    let weatherName:String = myStruct.list[i].weather[0].main!
                    self.weatherNameArray.append(weatherName)
                    
                    let lowest_temp_value = myStruct.list[i].main.temp_min
                    self.lowest_temp_array.append(Double(lowest_temp_value!))
                    
                    let highest_temp_value = myStruct.list[i].main.temp_max
                    self.highest_temp_array.append(Double(highest_temp_value!))
                }
                
                
                //for hours
                self.time = []
                self.temp = []
                self.image = []
                self.days = []
                
                
                //for hours
                for j in 0...6 {
                    
                    let time = self.getTime(timeInterval: self.dt_Array[j])
                    let date = self.getDate(timeInterval: self.dt_Array[j])
                    
                    
                    let accurateTime: String = time[0]
                    let AM_PM: String = time[3]
                    
                    let timeStamp: String = "\(accurateTime) \(AM_PM)"
                    print(timeStamp)
                    
                    self.time.append(timeStamp)
                    
                    let tempInK: Double = self.temp_Array[j]
                    let tempInC: Double = tempInK - Constants.kelvin
                    
                    self.temp.append(tempInC)
                    
                    self.image.append(self.weatherNameArray[j])
                    
                }
                
                
                
                
                //for days
                self.daysImage = []
                self.lowestTemp = []
                self.highestTemp = []
                
                for d in 0...self.dt_Array.count - 1{
                    
                    let desiredDay: Day = WeatherViewController.Day(rawValue: self.getDesiredDay(timeInterval: self.dt_Array[d]))!
                    print("\(d) , \(desiredDay)")
//                    let dayDot: Day = Day.Friday
                    //        var dayDot = Day.male
                    //Switch Statement using enums :
                    
                    if(desiredDay.rawValue != self.getCurrentDay()){
                        
                        switch desiredDay {
                            
                        case .Monday:
                            print("day is Monday")
                            
                            if(self.mondayCount == 0){
                                self.days.append(desiredDay.rawValue)
                                self.daysImage.append(self.weatherNameArray[d])
                                
                                self.setLowHighTemp(index: d)
                                
                                self.mondayCount = 1
                            }
                            
                            
                        case .Tuesday:
                            print("day is Tuesday”")
                            if(self.tuesdayCount == 0){
                                self.days.append(desiredDay.rawValue)
                                self.daysImage.append(self.weatherNameArray[d])
                                self.setLowHighTemp(index: d)
                                
                                self.tuesdayCount = 1
                                
                            }
                            
                        case .Wednesday:
                            print("day is Wednesday”")
                            if(self.wednesdayCount == 0){
                                self.days.append(desiredDay.rawValue)
                                self.daysImage.append(self.weatherNameArray[d])
                                self.setLowHighTemp(index: d)
                                
                                self.wednesdayCount = 1
                                
                            }
                            
                        case .Thursday:
                            print("day is Thursday”")
                            if(self.thursdayCount == 0){
                                self.days.append(desiredDay.rawValue)
                                self.daysImage.append(self.weatherNameArray[d])
                                self.setLowHighTemp(index: d)
                                
                                self.thursdayCount = 1
                                
                            }
                            
                        case .Friday:
                            print("day is Friday”")
                            if(self.fridayCount == 0){
                                self.days.append(desiredDay.rawValue)
                                self.daysImage.append(self.weatherNameArray[d])
                                self.setLowHighTemp(index: d)
                                
                                self.fridayCount = 1
                                
                            }
                            
                        case .Saturday:
                            print("day is Saturday”")
                            if(self.saturdayCount == 0){
                                self.days.append(desiredDay.rawValue)
                                self.daysImage.append(self.weatherNameArray[d])
                                self.setLowHighTemp(index: d)
                                
                                self.saturdayCount = 1
                                
                            }
                            
                        case .Sunday:
                            print("day is Sunday”")
                            if(self.sundayCount == 0){
                                self.days.append(desiredDay.rawValue)
                                self.daysImage.append(self.weatherNameArray[d])
                                self.setLowHighTemp(index: d)
                                
                                self.sundayCount = 1
                                
                            }
                            
                        }
                    }
                    
                    
                    
                }
                
                
                
                

                DispatchQueue.main.async {
                    self.cityName.text = "\(cityName)"
                    self.status.text = "\(weatherStatus)"
                    
                    
                    self.temprature.text = "\(mainTempinConverted)°C"
                    
                    self.minimumTemp = minTempinC
                    self.maximumTemp = maxTempinC
                    
                    let currentDay = self.getCurrentDay()
                    self.day = currentDay
                    
                    self.weatherTableView.reloadData()
                    
                    let weather: Weather = WeatherViewController.Weather(rawValue: weatherStatus)!
                    self.setBackgroundImage(weather: weather)
                    
                        
                    
                }
                
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
            
            
            }.resume()
        
        
    }
    
    
    
    func getTime(timeInterval: Double) -> [String] {
        
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.none //Set date style
        dateFormatter.timeZone = .current  //TimeZone(identifier: "Asia/Calcutta")//
        let localDate: String = dateFormatter.string(from: date) //TimeZone(identifier: "Europe/Amsterdam")
        let seperateLocalDate = localDate.components(separatedBy: [":"," "])
        return seperateLocalDate
       
    }
    
    func getDate(timeInterval: Double) -> String {
        
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current  //TimeZone(identifier: "Asia/Calcutta")//
        let localDate: String = dateFormatter.string(from: date) //TimeZone(identifier: "Europe/Amsterdam")
        let seperateLocalDate = localDate.components(separatedBy: [":"," "])
        return localDate
        
    }
    
    func getCurrentDay() -> String{
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        
        return dayInWeek
    }
    
    func getDesiredDay(timeInterval: Double) -> String {
        
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        
        return dayInWeek
    }
    
    

    func setupTableView(){
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self

        
        
        weatherTableView.register(UINib(nibName: "TodayTableViewCell", bundle: nil), forCellReuseIdentifier: "TodayTableViewCell")
//        weatherTableView.register(UINib(nibName: "HourlyTableViewCell", bundle: nil), forCellReuseIdentifier: "HourlyTableViewCell")
        weatherTableView.register(UINib(nibName: "WeeklyTableViewCell", bundle: nil), forCellReuseIdentifier: "WeeklyTableViewCell")
        weatherTableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        weatherTableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailsTableViewCell")

    }


}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize = CGSize(width:67 , height:100)

        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7 //model[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCVC", for: indexPath) as! HourlyCVC
            
            cell.time.text = "\(self.time[indexPath.item])"
            cell.image.image = UIImage(named: "\(image[indexPath.item])")
            cell.temp.text = String(format: "%.f", temp[indexPath.item])
        
            return cell
            
      
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}


extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyTableViewCell", for: indexPath)
        //        cell.selectionStyle = .none
        //
        //        return cell
        
        
        if(indexPath.section == 0){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodayTableViewCell", for: indexPath) as! TodayTableViewCell
            
            cell.day.text = self.day
            cell.day2.text = "Today"
            
            
            let minimumTempConverted = String(format: "%.f", self.minimumTemp)
            let maximumTempConverted = String(format: "%.f", self.maximumTemp)

            cell.lowestTemp.text = "\(minimumTempConverted)°"
            cell.highestTemp.text = "\(maximumTempConverted)°"
        
            cell.selectionStyle = .none
            cell.todayView.layer.cornerRadius = 10
            
            return cell
            
        }else if(indexPath.section == 1){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyTableViewCell", for: indexPath)
            cell.selectionStyle = .none
            
            return cell
            
        }else if(indexPath.section == 2){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyTableViewCell", for: indexPath) as! WeeklyTableViewCell
            
            cell.day.text = "\(days[indexPath.row])"
            cell.tempImage.image = UIImage(named: "\(daysImage[indexPath.row])")
            cell.lowestTemp.text = String(format: "%.f", lowestTemp[indexPath.row]) // "\(lowestTemp[indexPath.row])"
            cell.highestTemp.text = String(format: "%.f", highestTemp[indexPath.row]) //"\(highestTemp[indexPath.row])"
            cell.weeklyView.layer.cornerRadius = 10

            cell.selectionStyle = .none
            
            if(indexPath.row == 4){
                
                cell.seperator.isHidden = false
            }else{
                cell.seperator.isHidden = true
            }
            
            
            return cell
            
        }else if(indexPath.section == 3){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell
            
            cell.tempDesc.text = "Today's weather: \(temprature_description)"
            cell.descriptionView.layer.cornerRadius = 10

            cell.selectionStyle = .none
            
            return cell
            
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cell.leftView.layer.cornerRadius = 10
            cell.rightView.layer.cornerRadius = 10

            cell.selectionStyle = .none

            
            if(indexPath.row == 0){
                
                cell.topLabel1.text = "HUMIDITY"
                cell.bottomLabel1.text = "\(String(format: "%.f", self.humidity))%" // "\(self.humidity)%"
                cell.topLabel2.text = "PRESSURE"
                cell.bottomLabel2.text = "\(String(format: "%.f", self.pressure)) hPa" // "\(self.pressure) hPa"

                cell.seperator.isHidden = false

            }else if(indexPath.row == 1){
                
                
                cell.topLabel1.text = "SEA LEVEL"
                cell.bottomLabel1.text = "\(String(format: "%.f", self.sea_level)) hPa" // "\(self.sea_level) hPa"
                cell.topLabel2.text = "GROUND LEVEL"
                cell.bottomLabel2.text = "\(String(format: "%.f", self.ground_level)) hPa" // "\(self.ground_level) hPa"

                cell.seperator.isHidden = false

            }else if(indexPath.row == 2){
                
                cell.topLabel1.text = "Wind speed"
                cell.bottomLabel1.text = "\(String(format: "%.f", self.wind_speed)) m/s" // "\(self.wind_speed) meter/sec"
                cell.topLabel2.text = "Wind direction"
                cell.bottomLabel2.text = "\(String(format: "%.f", self.wind_direction))°" // "\(self.wind_direction) degrees"

                cell.seperator.isHidden = false

            }else {
                
                cell.topLabel1.text = "Cloudiness"
                cell.bottomLabel1.text = "\(String(format: "%.f", self.cloudiness))%" // "\(self.cloudiness)%"
                cell.topLabel2.text = "Precipitation last 3 hours"
                cell.bottomLabel2.text = "\(String(format: "%.f", self.precipitation))%" // "\(self.precipitation)"
                
                cell.seperator.isHidden = true
            }
            
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(indexPath.section == 1){
            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyTableViewCell", for: indexPath) as! HourlyTableViewCell
//            cell.selectionStyle = .none
//
//            return cell
            
            guard let cell = cell as? HourlyTableViewCell else { return }
            
            cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
//            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0

            
        }
        

    }
    
//    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//
//
//        guard let tableViewCell = cell as? TableViewCell else { return }
//
//        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
//    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.section == 0){
            
            return 40
            
        }else if(indexPath.section == 1){
            
            return 105
            
        }else if(indexPath.section == 2){
            
            return 44
            
        }else if(indexPath.section == 3){
            
            let height = self.temprature_description.heightWithConstrainedWidth(width: self.view.bounds.width, font: UIFont(name: "HelveticaNeue-UltraLight", size: 17)!)
            let padding: CGFloat = 30
            
            return height + padding
            
        }else {
            
            return 65
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            
            return 1
            
        }else if(section == 1){
            
            return 1

        }else if(section == 2){
            
            return days.count
            
        }else if(section == 3){
            
            return 1
            
        }else {
            
            return 4
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    
    
    
    
    
    
}
