//////
//////  userModel.swift
//////  CuzHub
//////
//////  Created by Muhammad Ali Maniar on 11/2/17.
//////  Copyright © 2017 Appiskey. All rights reserved.
//////
////
//import Foundation
//import SwiftyJSON
////class UserModel : NSObject, NSCoding {
////    var id: Int = 0
////    var email: String = ""
////    var first_name : String = ""
////    var last_name : String = ""
////    var current_password = ""
////    var password : String = ""
////    var password_confirmation : String = ""
////    var address : String = ""
////    var dob : String  = ""
////    var name :String = ""
////    var rating :Int = 0
////    var deliveries : Int = 0
////
////    var phone : String = ""
////    var client_id : Int = 0
////    var username : String = ""
////    var image : String = ""
////    var license_id : Int = 0
////    var license_image : String = ""
////    var about : String = ""
////    var radius : Int = 0
////    var token : String = ""
////    var latitude:Double = 0.0
////    var longitude:Double = 0.0
////    var encrypted_id : String = ""
////    var verified : [Verified] = []
////    var license : [License] = []
////
////    var reviews: [Review] = []
////    var vehicle: VehicleCategory?
////    var role : AppRoles!
////    //    {
////    //        get {
////    //
////    //            return self.gettype(UserDefaults.standard.string(forKey: "role") ?? "") ?? .customer
////    //        } set {
////    //            UserDefaults.standard.set(newValue.rawValue.lowercased(), forKey: "role")
////    //        }
////    //    }
////    static let shared = UserModel()
////
////    override init() {
////        super.init()
////    }
////
////
////    static var userToken : String? {
////        get {
////            let user = UserDefaults.standard
////            return user.string(forKey: "token")
////
////        } set {
////            let user = UserDefaults.standard
////            user.set("Bearer \((newValue!))", forKey: "token")
////        }
////    }
////
////    func initilizer(with json : JSON)-> UserModel {
////        let obj = UserModel()
////        obj.id = json["id"].intValue
////        obj.email = json["email"].stringValue
////        latitude = Double(json["latitude"].stringValue) ?? 0.0
////        longitude = Double(json["longitude"].stringValue) ?? 0.0
////        obj.image = json["image"].stringValue.replacingOccurrences(of: "\\", with: "")
////        obj.name = json["name"]["full"].stringValue
////        obj.first_name = json["name"]["first"].stringValue
////        obj.last_name = json["name"]["last"].stringValue
////
////        if obj.name == "" {
////            obj.name = obj.first_name
////            if obj.first_name == "" {
////                obj.name = obj.last_name
////            } else {
////                obj.name += " " + obj.last_name
////            }
////        }
////
////        obj.rating = json["rating"].intValue
////        obj.deliveries = json["deliveries"].intValue
////        obj.password = json["password"].stringValue
////        obj.current_password = json["current_password"].stringValue
////        obj.license_id = json["license_id"].intValue
////        obj.license_image = json["license_image"].stringValue
////        obj.radius = json["radius"].intValue
////        obj.token = json["token"].stringValue
////        obj.phone = json["phone"].stringValue
////        obj.encrypted_id = json["encrypted_id"].stringValue
////        obj.about = json["about"].stringValue
////        obj.password_confirmation = json["password_confirmation"].stringValue
////        obj.address = json["address"]["string"].stringValue
////        //        obj.username = json["username"].stringValue
////        if json["verified"].exists() {
////            for verifiedObj in json["verified"].arrayValue {
////                obj.verified.append(Verified().initialize(fromJson: verifiedObj))
////            }
////        }
////        if json["license"].exists() {
////            for licenseObj in json["license"].arrayValue {
////                obj.license.append(License().initialize(fromJson: licenseObj))
////            }
////        }
////        if json["reviews"].exists() {
////            for review in json["reviews"].arrayValue {
////                obj.reviews.append(Review().initialize(fromJson: review))
////            }
////        }
////        if let type = self.gettype(json["type"].stringValue) {
////            obj.role = type
////        }
////        obj.vehicle = VehicleCategory().initialize(fromJson: json["vehicle"])
////
////        return obj
////    }
////
////    static func saveUserObject(obj: UserModel){
////        let encodedData = NSKeyedArchiver.archivedData(withRootObject: obj)
////        UserDefaults.standard.set(encodedData, forKey: "UserObject")
////    }
////
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
////    required init(coder decoder: NSCoder) {
////        super.init()
////        self.id = decoder.decodeInteger(forKey: "id") as? Int ?? 0
////
////        self.email = decoder.decodeObject(forKey: "email") as? String ?? ""
////        self.phone = decoder.decodeObject(forKey: "phone") as? String ?? ""
////        self.about = decoder.decodeObject(forKey: "about") as? String ?? ""
////        self.image = decoder.decodeObject(forKey: "image") as? String ?? ""
////        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
////        self.address = decoder.decodeObject(forKey: "address") as? String ?? ""
////        self.first_name = decoder.decodeObject(forKey: "first_name") as? String ?? ""
////        self.encrypted_id = decoder.decodeObject(forKey: "encrypted_id") as? String ?? ""
////        self.last_name = decoder.decodeObject(forKey: "last_name") as? String ?? ""
////        let deliveriesStr = decoder.decodeObject(forKey: "deliveries") as? String ?? ""
////        self.deliveries = Int(deliveriesStr) ?? 0
////
////        let ratingStr = decoder.decodeObject(forKey: "rating") as? String ?? ""
////        self.rating = Int(ratingStr) ?? 0
////        self.role = self.gettype(decoder.decodeObject(forKey: "role") as? String ?? "")
////        //        if let type = decoder.decodeObject(forKey: "type") as? String{
////        //            if let user = self.gettype(type) {
////        //                self.role = user
////        //            }
////        //        }
////
////    }
////    func encode(with coder: NSCoder) {
////
////        coder.encode(id, forKey: "id")
////        coder.encode(encrypted_id, forKey: "encrypted_id")
////        coder.encode(email, forKey: "email")
////        coder.encode(phone, forKey: "phone")
////        coder.encode(about, forKey :"about")
////        coder.encode(name, forKey :"name")
////        coder.encode(image, forKey :"image")
////        coder.encode(address, forKey: "address")
////        coder.encode(first_name, forKey: "first_name")
////        coder.encode(last_name, forKey: "last_name")
////        coder.encode("\(deliveries)", forKey: "deliveries")
////        coder.encode(role.rawValue.lowercased(), forKey :"role")
////        coder.encode("\(rating)", forKey :"rating")
////
////        if let typevalue = role {
////            coder.encode(typevalue.rawValue, forKey: "type")
////        }
////    }
////
////
////    static func getUserObject() -> UserModel?{
////
////        if let data = UserDefaults.standard.data(forKey: "UserObject"),
////            let userObj = NSKeyedUnarchiver.unarchiveObject(with: data) as? UserModel {
////            return userObj
////        } else {
////            return nil //UserModel()
////        }
////    }
////
////}
////extension NSObject {
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
////                    Utilities.shared.showAlert(title: "Alert", message: failure.message)
////                } else {
////                    //ProfileAPI ERROR
////                    var dic = data.dictionaryValue["errors"]?.dictionaryValue
////                    if dic == nil {
////                        dic = data.dictionaryValue
////                    }
////                    for (_, array) in dic! {
////                        let values = array.arrayValue
////                        Utilities.shared.showAlert(title: "Alert", message: (values.first?.stringValue) ?? "Error")
////                        break
////
////                    }
////                }
////            } else{
////                Utilities.shared.showAlert(title: "Alert", message: failure.message)
////            }
////
////        case .authError :
////
////            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
////
////            Utilities.shared.showAlert(title: "Alert", message: failure.message)
////            appDelegate.gotoLogin()
////
////        case .unknown :
////            Utilities.shared.showAlert(title: "Alert", message: failure.message)
////        case .networkIssue :
////            Utilities.shared.showAlert(title: "Alert", message: failure.message)
////        case .timeOut :
////            Utilities.shared.showAlert(title: "Alert", message: failure.message)
////
////        case .notVerified:
////            Utilities.shared.showAlert(title: "Alert", message: failure.message)
////        }
////    }
////}
////// User Address Map View Controller
////class Address {
////
////    var country:String = ""
////    var state:String = ""
////    var city:String = ""
////    var zip:String = ""
////    var address:String = ""
////    var latitude:Double = 0.0
////    var longitude:Double = 0.0
////
////    init() {}
////
////    init(
////        country:String,
////        state:String,
////        city:String,
////        zip:String,
////        address:String,
////        latitude:Double,
////        longitude:Double
////
////        ) {
////
////
////        self.country = country
////        self.state = state
////        self.city = city
////        self.zip = zip
////        self.address = address
////        self.latitude = latitude
////        self.longitude = longitude
////
////
////
////    }
////
////    init(fromJson json: JSON){
////        address = json["address"].stringValue
////        city = json["city"].stringValue
////        country = json["country"].stringValue
////        latitude = Double(json["latitude"].stringValue) ?? 0.0
////        longitude = Double(json["longitude"].stringValue) ?? 0.0
////        state = json["state"].stringValue
////        zip = json["zip"].stringValue
////    }
////
////}
//
//
//class Verified {
//    var email : String = ""
//    var phone : String = ""
//    func initialize(fromJson json : JSON) -> Verified {
//        let obj = Verified()
//        obj.email = json["email"].stringValue
//        obj.phone = json["phone"].stringValue
//        return obj
//    }
//}
//class License {
//    var id : Int = 0
//    var image : [UserImageModel] = []
//    func initialize(fromJson json: JSON) -> License {
//        let obj = License()
//        obj.id = json["id"].intValue
//        if json["image"].exists() {
//            for imageObj in json["image"].arrayValue {
//                let image = UserImageModel().parse(fromJson: imageObj)
//                obj.image.append(image)
//                
//            }
//        }
//        
//        return obj
//    }
//}
//class UserImageModel {
//    var image : String = ""
//    func parse(fromJson : JSON) -> UserImageModel {
//        let obj = UserImageModel()
//        obj.image = fromJson["image"].stringValue
//        return obj
//    }
//}
////VehicleModel
//class VehicleModel {
//    var id : Int = 0
//    var type : String = ""
//    var model : Int = 0
//    var year : String = ""
//    var created_at : Date?
//    var updated_at : String = ""
//    var images : [Image] = []
//    var inspections : [Image] = []
//    var insurances  : [Image] = []
//    
//    func parse(fromJson json : JSON) -> VehicleModel {
//        let obj = VehicleModel()
//        obj.id = json["id"].intValue
//        obj.type = json["type"].stringValue
//        obj.model = json["model"].intValue
//        obj.year = json["year"].stringValue
//        obj.created_at = DateManager.shared.getDate(from: json["created_at"].stringValue, format: .dateTime)
//        obj.updated_at = json["updated_id"].stringValue
//        if json["images"].exists() {
//            for imgObj in json["images"].arrayValue {
//                let image = Image().parse(fromJson: imgObj)
//                obj.images.append(image)
//            }
//        }
//        if json["inspections"].exists() {
//            for imgobj in json["inspections"].arrayValue {
//                let image = Image().parse(fromJson: imgobj)
//                obj.images.append(image)
//            }
//        }
//        if json["insurances"].exists() {
//            for imgObj in json["insurances"].arrayValue {
//                let image = Image().parse(fromJson: imgObj)
//                obj.images.append(image)
//            }
//        }
//        return obj
//    }
//    
//}
//class Image {
//    var id : Int = 0
//    var path : String = ""
//    var created_at : String = ""
//    var updated_at : String = ""
//    func parse(fromJson : JSON) -> Image {
//        let obj = Image()
//        obj.id = fromJson["id"].intValue
//        obj.path = fromJson["path"].stringValue
//        obj.created_at = fromJson["created_at"].stringValue
//        obj.updated_at = fromJson["updated_at"].stringValue
//        return obj
//    }
//}
