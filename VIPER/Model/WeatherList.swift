////
////  userModel.swift
////  CuzHub
////
////  Created by Muhammad Ali Maniar on 11/2/17.
////  Copyright © 2017 Appiskey. All rights reserved.
////
//
//import Foundation
//import SwiftyJSON
//class WeatherList : NSObject, NSCoding {
//    
//    var cnt : Int = 0
//    var message : Double = 0.0
//    var cod : String = ""
//    
//    var list : [List] = []
//    //    var verified : [Verified] = []
//
//    static let shared = WeatherList()
//
//    override init() {
//        super.init()
//    }
//
//
//    func initilizer(with json : JSON)-> WeatherList {
//        let obj = WeatherList()
//        obj.cnt = json["cnt"].intValue
//        obj.message = json["message"].doubleValue
//        obj.cod = json["cod"].stringValue
//
//        if json["list"].exists() {
//            for listObj in json["list"].arrayValue {
//                obj.list.append(List().initialize(fromJson: listObj))
//            }
//        }
//
//        return obj
//    }
//    
//    static func getUserObject() -> WeatherList?{
//        
//                if let data = UserDefaults.standard.data(forKey: "UserObject"),
//                    let userObj = NSKeyedUnarchiver.unarchiveObject(with: data) as? WeatherList {
//                    return userObj
//                } else {
//                    return nil //UserModel()
//                }
//        
//    }
//
//    static func saveUserObject(obj: WeatherList){
//        let encodedData = NSKeyedArchiver.archivedData(withRootObject: obj)
//        UserDefaults.standard.set(encodedData, forKey: "WeatherObject")
//    }
//
////    private func gettype (_ type : String) -> AppRoles? {
////        if type == "customer" {
////            return  .customer
////        } else if type == "driver" {
////            return  .driver
////        } else if  type == "helper" {
////            return .helper
////        } else {
////            return nil
////        }
////    }
////
//    required init(coder decoder: NSCoder) {
//        super.init()
//        
//        self.cnt = decoder.decodeInteger(forKey: "cnt") as? Int ?? 0
//        self.cod = decoder.decodeObject(forKey: "cod") as? String ?? ""
//        self.message = decoder.decodeObject(forKey: "message") as? Double ?? 0.0
//
//
//    }
//    func encode(with coder: NSCoder) {
//
//        coder.encode(cnt, forKey: "cnt")
//        coder.encode(cod, forKey: "cod")
//        coder.encode(message, forKey: "message")
//    }
//
//
////    static func getUserObject() -> UserModel?{
////
////        if let data = UserDefaults.standard.data(forKey: "UserObject"),
////            let userObj = NSKeyedUnarchiver.unarchiveObject(with: data) as? UserModel {
////            return userObj
////        } else {
////            return nil //UserModel()
////        }
////    }
//
//}
//extension NSObject {
////    func switchFailure(_ failure: Failure) {
////
////        print(failure.code)
////        print(failure.message)
////
////        switch failure.code {
////        case .failure :
////
////            if let data = failure.data {
////                print("Failure Data :-> \(data)")
////                if data.dictionaryValue.isEmpty {
////
//////                    Utilities.shared.showAlert(title: "Alert", message: failure.message)
////                } else {
////                    //ProfileAPI ERROR
////                    var dic = data.dictionaryValue["errors"]?.dictionaryValue
////                    if dic == nil {
////                        dic = data.dictionaryValue
////                    }
////                    for (_, array) in dic! {
////                        let values = array.arrayValue
//////                        Utilities.shared.showAlert(title: "Alert", message: (values.first?.stringValue) ?? "Error")
////                        break
////
////                    }
////                }
////            } else{
//////                Utilities.shared.showAlert(title: "Alert", message: failure.message)
////            }
////
////        case .authError :
////
////            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
////
//////            Utilities.shared.showAlert(title: "Alert", message: failure.message)
//////            appDelegate.gotoLogin()
////
//////        case .unknown :
////////            Utilities.shared.showAlert(title: "Alert", message: failure.message)
//////        case .networkIssue :
////////            Utilities.shared.showAlert(title: "Alert", message: failure.message)
//////        case .timeOut :
////////            Utilities.shared.showAlert(title: "Alert", message: failure.message)
//////
//////        case .notVerified:
//////            Utilities.shared.showAlert(title: "Alert", message: failure.message)
////        }
////    }
//}
//
//class List {
//    var dt : Double = 0.0
//
//    func initialize(fromJson json : JSON) -> List {
//        let obj = List()
//        obj.dt = json["dt"].doubleValue
//        return obj
//    }
//}
