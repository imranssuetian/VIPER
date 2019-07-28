//
//  ViewController.swift
//  VIPER
//
//  Created by macintosh on 22/07/2019.
//  Copyright © 2019 macintosh. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var temprature: UILabel!
    @IBOutlet weak var weatherTableView: UITableView!
    
    @IBOutlet weak var wetaher: UICollectionView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //Hourly table view cell data
    var time = ["Now","2 AM","3 AM","4 AM","5 AM","6 AM","7 AM"]

    let days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    let image = ["clear-day","clear-night","dark-sky-logo","fog","partly-cloudy-day","partly-cloudy-night","rain"] //sleet snow wind
    var temp = [31.0,32.1,32.1,32.1,32.1,32.1,32.1]
    
    var dt_Array = [Double]()
    var temp_Array = [Double]()
    var weatherImage = ["","","","","","",""]
    
    var today: String = ""
    var day: String = ""
    var minimumTemp: Double = 0
    var maximumTemp: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Hello world")
        
//        backgroundImage.image = UIImage.gif(url: rain)

        setupTableView()
        
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?id=1275339&APPID=39d3df86cda45bf4394dbeb18fa015d9"

//        APIRouter.urlRequest(modelType: WeatherInfo.self, urlString: urlString)
    
        urlRequest(urlString: urlString)

        

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
                
                let myStruct = try JSONDecoder().decode(WeatherInfo.self, from: data)
       
                let cityName : String = myStruct.city.name!
                let weatherStatus : String = myStruct.list[0].weather[0].main!
                let mainTempinK: Double = myStruct.list[0].main.temp!
                let mainTempinC: Double = mainTempinK - Constants.kelvin
                let mainTempinConverted: String = String(format: "%.f", mainTempinC)
                
                
                
                let maxTempinK: Double = myStruct.list[0].main.temp_max!
                let maxTempinC: Double = maxTempinK - Constants.kelvin

                let minTempinK: Double = myStruct.list[0].main.temp_min!
                let minTempinC: Double = minTempinK - Constants.kelvin
                
                for i in 0...39 {
                    
                    let dt_value = myStruct.list[i].dt
                    self.dt_Array.append(Double(dt_value!))
                    
                    let temp_value = myStruct.list[i].main.temp
                    self.temp_Array.append(Double(temp_value!))
                }
                
                self.time = []
                self.temp = []
                
                for j in 0...6 {
                    
                    let date = self.getDate(timeInterval: self.dt_Array[j])
                    let time: String = date[0]
                    let status: String = date[3]
                    
                    let timeStamp: String = "\(time) \(status)"
                    print(timeStamp)
                    
                    self.time.append(timeStamp)
                    
                    let tempInK: Double = self.temp_Array[j]
                    let tempInC: Double = tempInK - Constants.kelvin
                    
                    self.temp.append(tempInC)
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
                }
                
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
            
            
            }.resume()
        
        
    }
    
    func getDate(timeInterval: Double) -> [String] {
        
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.none //Set date style
        dateFormatter.timeZone = .current  //TimeZone(identifier: "Asia/Calcutta")//
        let localDate: String = dateFormatter.string(from: date) //TimeZone(identifier: "Europe/Amsterdam")
        let seperateLocalDate = localDate.components(separatedBy: [":"," "])
        return seperateLocalDate
       
    }
    
    func getCurrentDay() -> String{
        
        let date = Date()
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
            
            return cell
            
        }else if(indexPath.section == 1){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyTableViewCell", for: indexPath)
            cell.selectionStyle = .none
            
            return cell
            
        }else if(indexPath.section == 2){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyTableViewCell", for: indexPath) as! WeeklyTableViewCell
            
            cell.day.text = "\(days[indexPath.row])"
            cell.tempImage.image = UIImage(named: "\(image[indexPath.row])")
            cell.lowestTemp.text = "29"
            cell.highestTemp.text = "35"
            cell.selectionStyle = .none
            
            if(indexPath.row == 6){
                
                cell.seperator.isHidden = false
            }else{
                cell.seperator.isHidden = true
            }
            
            
            return cell
            
        }else if(indexPath.section == 3){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell
            
            cell.tempDesc.text = "Today: Partly cloudy condtions with a heat index of 41° and 26 km/hr winds from the south-west."
            cell.selectionStyle = .none
            
            return cell
            
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            
            cell.topLabel1.text = "SUNRISE"
            cell.bottomLabel1.text = "5:30 AM"
            cell.topLabel2.text = "SUNSET"
            cell.bottomLabel2.text = "7:30 PM"
            cell.selectionStyle = .none
            
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
            
            return 35
            
        }else if(indexPath.section == 1){
            
            return 105
            
        }else if(indexPath.section == 2){
            
            return 44
            
        }else if(indexPath.section == 3){
            
            return 82
            
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
            
            return 7
            
        }else if(section == 3){
            
            return 1
            
        }else {
            
            return 5
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    
    
    
    
    
    
}
