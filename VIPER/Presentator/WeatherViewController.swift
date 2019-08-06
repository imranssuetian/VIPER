//
//  ViewController.swift
//  VIPER
//
//  Created by Imran Shah on 22/07/2019.
//  Copyright © 2019 Imran Shah. All rights reserved.
//

import UIKit
import OpenWeatherKit
import SVProgressHUD
import SwiftyJSON

class WeatherViewController: UIViewController {

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var temprature: UILabel!
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var wetaher: UICollectionView!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    
    //for hours
    var time: [String] = []
    var temp: [Double] = []
    var image: [String] = [] //sleet snow wind
    var dt_Array = [Double]()
    var temp_Array = [Double]()
    var weatherNameArray = [String]()
    var today: String = ""
    var day: String = ""
    var minimumTemp: Double = 0
    var maximumTemp: Double = 0
    
    //for days
    var days: [String] = []
    var daysImage: [String] = [] //sleet snow wind
    var lowestTemp: [Double] = []
    var highestTemp: [Double] = []
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
    
    var temprature_description: String = ""
    
    var cityID: [CityID] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Hello world")
        
        self.setupUI()
        self.setupTableView()
        self.checkCity(fileName: "city_list", cityName: searchTextField.text!)
        
    }
    
    func checkCity(fileName: String,cityName: String){
        self.searchTextField.text = ""
        
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                
                let jsonData = try decoder.decode([CityID].self, from: data)
                
                if(cityName == ""){
                    
                    self.setupAPI(city_id: "707860")
                    
                }else{
                    
                    for city in jsonData {
                        
                        print(city.name)
                        
                        if(cityName == city.name){
                            
                            let city_code = city.id
                            let city_code_string = String(city_code)
                            self.setupAPI(city_id: city_code_string)
                            
                        }
                        
                    }
                    print("imran")
                }
                
                print(jsonData[1].name)
                
                
            } catch {
                print("error:\(error)")
            }
        }

        
    }
    
    func loadJson(filename fileName: String) -> [CityID]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                return jsonData.Cities
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    func setupAPI(city_id: String){
        
        let base_url = "http://api.openweathermap.org/data/2.5/forecast?id="
//        let city_id = "1174872"
        let mics = "&APPID="
        let api_key = "39d3df86cda45bf4394dbeb18fa015d9"
        
        let urlString = base_url + city_id + mics + api_key
        urlRequest(urlString: urlString)

        
    }
    
    
    func setupUI(){
        searchView.layer.cornerRadius = 10
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search By City", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        searchTextField.returnKeyType = .search
        searchTextField.delegate = self
        
    }
    
    @IBAction func didTappedSearchField(_ sender: UITextField) {
        
        print("did tapped")
//        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
//        let window = UIApplication.shared.keyWindow
//        window?.rootViewController = rootVC

        
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
            
            backgroundImage.image =  UIImage.gif(url: clear_day)
            
            
        case .Rain:
            
            backgroundImage.image = UIImage.gif(url: blueClouds)
            UIApplication.shared.statusBarStyle = .lightContent
            
            
        case .Snow:
            
            backgroundImage.image = UIImage.gif(url: snow)
            
        case .Clouds:
            
            backgroundImage.image = UIImage.gif(url: clear_day)
            UIApplication.shared.statusBarStyle = .lightContent
            
        case .Fog:
            
            backgroundImage.image = UIImage.gif(url: fog)
            UIApplication.shared.statusBarStyle = .lightContent
            
            
        case .Sun:
            
            backgroundImage.image = UIImage.gif(url: sun)
            
            
        case .Wind:
            
            backgroundImage.image = UIImage.gif(url: wind)
            
        }
        
    }
    
    
    
    func urlRequest(urlString: String) {
        self.mainView.isHidden = true
        SVProgressHUD.show(withStatus: "Loading Request")

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
                self.dt_Array = []
                self.temp_Array = []
                self.weatherNameArray = []
                self.lowest_temp_array = []
                self.highest_temp_array = []
                
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
                
                self.mondayCount = 0
                self.tuesdayCount = 0
                self.wednesdayCount = 0
                self.thursdayCount = 0
                self.fridayCount = 0
                self.saturdayCount = 0
                self.sundayCount = 0
                
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
                    
                    SVProgressHUD.dismiss()
                    self.mainView.isHidden = false

                    
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


    @IBAction func didTappedSearch(_ sender: UIButton) {
        
        print("Search Tapped")
        self.view.endEditing(true)
        self.checkCity(fileName: "city_list", cityName: searchTextField.text!)
        

    }
    
    
}



extension WeatherViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("Search Tapped")
        self.view.endEditing(true)
        self.checkCity(fileName: "city_list", cityName: searchTextField.text!)

        
        return true
    }
    
}



