//
//  WeatherTableView.swift
//  VIPER
//
//  Created by macintosh on 06/08/2019.
//  Copyright © 2019 macintosh. All rights reserved.
//

import Foundation
import UIKit
import OpenWeatherKit
import SVProgressHUD
import SwiftyJSON

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
            
            if(dt_Array.count > 0){
                
                return 1
                
            }else{
                
                return 0
                
            }
            
            
        }else if(section == 1){
            
            if(dt_Array.count > 0){
                
                return 1
                
            }else{
                
                return 0
                
            }
            
        }else if(section == 2){
            
            if(days.count > 0){
                
                return days.count
                
            }else{
                
                return 0
                
            }
            
            
        }else if(section == 3){
            
            if(dt_Array.count > 0){
                
                return 1
                
            }else{
                
                return 0
                
            }
            
        }else {
            
            if(dt_Array.count > 0){
                
                return 4
                
            }else{
                
                return 0
                
            }
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
}
