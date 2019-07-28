////
////  UserAPI.swift
////  CuzHub
////
////  Created by admin on 28/02/2018.
////  Copyright © 2018 Appiskey. All rights reserved.
////
//
//import Foundation
//
//class UserAPI : NSObject {
//    static let shared = UserAPI()
//    
//    func signUpAPI(typeUser : Any, /*username: String,*/ email: String, contact: String, Password: String, password_confirmation: String, completion: @escaping (Bool) -> ()) {
//        let dictionary : [String : Any] = ["type": typeUser,/*"type" : username,*/
//            "phone" : contact,
//            "email" : email,
//            "password" : Password,
//            "password_confirmation" : password_confirmation
//        ]
//        Loader.getInstance().show()
//        
//        APIRouter.API_Request(typeOfCall: .account, params: dictionary, method: .post) { (response) in
//            Loader.getInstance().dismiss()
//            switch response {
//                
//            case .success(let success) :
//                
//                let user = WeatherList.getUserObject()
//                let intializeUser = WeatherList().initilizer(with: success.data)
//                WeatherList.saveUserObject(obj: intializeUser)
//                
//                completion(true)
//                return
//                
//                
//            case .failure(let failure):
//                
//                completion(false)
//                self.switchFailure(failure)
//                return
//            }
//        }
//    }
//    
//    func getUser (completion: @escaping (UserModel?) -> ()){
//        
//        guard let header = UserModel.userToken else { return }
//        
//        Loader.getInstance().show()
//        APIRouter.API_Request(typeOfCall: .account, authToken:header) { (response) in
//            Loader.getInstance().dismiss()
//            switch response {
//                
//            case .success(let success) :
//                
//                var user = UserModel.getUserObject()
//                user = UserModel().initilizer(with: success.data)
//                
//                UserModel.saveUserObject(obj: user!)
//                
//                completion(user)
//                return
//                
//            case .failure(let failure):
//                
//                self.switchFailure(failure)
//                return
//            }
//        }
//    }
//    
//    func forgotAPI(email: String, completion: @escaping (String)->() ) {
//        let dictionary : [String : Any] = ["email" : email]
//        Loader.getInstance().show()
//        APIRouter.API_Request(typeOfCall: callType.forgetPassword, params: dictionary, method: .post) { (reponse) in
//            
//            Loader.getInstance().dismiss()
//            switch reponse {
//            case .success(let success):
//                let message : String = success.data["message"].stringValue
//                
//                completion(message)
//                return
//            case .failure(let failure):
//                self.switchFailure(failure)
//                return
//            }
//        }
//    }
//    
//    func loginAPI(email: String, password: String, completion: @escaping (Bool)->() )  {
//        let dictionary : [String : Any] = ["username" : email,
//                                           "password" : password,
//                                           "client_secret" : Constants.client_secret,
//                                           "client_id" : Constants.client_id,
//                                           "grant_type" : Constants.grant_type
//        ]
//        
//        Loader.getInstance().show()
//        APIRouter.API_Request(typeOfCall: callType.oauthToken, params: dictionary, method: .post){ (reponse) in
//            Loader.getInstance().dismiss()
//            switch reponse {
//                
//            case .success(let success) :
//                
//                if success.data["access_token"].exists() {
//                    
//                    UserModel.userToken = success.data["access_token"].stringValue
//                    completion(true)
//                    
//                }
//                
//            case .failure(let failure):
//                
//                completion(false)
//                self.switchFailure(failure)
//            }
//        }
//    }
//    func numberVerify(token: String, completion: @escaping (String)->()) {
//        let dictionary : [String : Any] = ["token": Int(token)!]
//        Loader.getInstance().show()
//        APIRouter.API_Request(typeOfCall: callType.verify, params: dictionary, method: .post, authToken: UserModel.userToken) { (reponse) in
//            Loader.getInstance().dismiss()
//            switch reponse {
//            case .success(let success) :
//                if success.data["message"].exists() {
//                    completion (success.data["message"].stringValue)
//                }
//                return
//            case .failure(let failure) :
//                self.switchFailure(failure)
//                return
//            }
//        }
//        
//    }
//    //Resend Number Verification
//    func resend(completion :@escaping (String)-> ()) {
//        guard let header = UserModel.userToken else {
//            return
//        }
//        Loader.getInstance().show()
//        APIRouter.API_Request( typeOfCall: callType.resend, method: .post, authToken: header) { (response) in
//            Loader.getInstance().dismiss()
//            switch response {
//            case .success(let success):
//                if success.data["message"].exists() {
//                    completion (success.data["message"].stringValue)
//                }
//                return
//            case .failure(let failure):
//                self.switchFailure(failure)
//                return
//            }
//        }
//    }
//    func profileApi (typeUser : Any,firstname: String , image: UIImage? = nil, lastname: String, address: String , aboutMe : String , method : String, completion: @escaping (Bool)->()) {
//        
//        guard let hearder = UserModel.userToken else { return }
//        var media : Media?
//        if image != nil {
//            media = Media(key: "image", image: image!)
//        }
//        var fcm = ""
//        if let fcm_token = UserDefaults.standard.string(forKey: "fcm_token")  {
//            
//            fcm = fcm_token
//            
//        }
//        var dictionary : [String : Any] = ["firstname": firstname ,"lastname" : lastname ,"about" : aboutMe , "_method" : method, "type" : typeUser, "address_string": address ]
//        if fcm != ""{
//            dictionary["fcm"] = fcm
//        }
//        Loader.getInstance().show()
//        APIRouter.API_Request(typeOfCall: callType.account, params: dictionary, method: .post, authToken: hearder, media: media) { (reponse) in
//            Loader.getInstance().dismiss()
//            switch reponse {
//            case .success(let success) :
//                var user = UserModel.getUserObject()
//                user = user?.initilizer(with: success.data)
//                UserModel.saveUserObject(obj: user!)
//                completion(true)
//            case .failure(let failure) :
//                self.switchFailure(failure)
//                completion(false)
//                return
//            }
//            
//        }
//    }
//    
//    func updateFCMToken (fcm: String, completion: @escaping (Bool)->()) {
//        
//        guard let hearder = UserModel.userToken else { return }
//        var dictionary : [String : Any] = ["fcm": fcm , "device": "ios", "_method" : "PUT"]
//        Loader.getInstance().show()
//        APIRouter.API_Request(typeOfCall: callType.account, params: dictionary, method: .post, authToken: hearder) { (reponse) in
//            Loader.getInstance().dismiss()
//            switch reponse {
//            case .success(let success) :
//                
//                completion(true)
//            case .failure(let failure) :
//                
//                completion(false)
//                return
//            }
//            
//        }
//    }
//    
//    func changePassword( method : String  , password : String  , current_password :String  , password_confirmation :String , completion: @escaping (String)->()) {
//        let dictionary : [String : Any] = [ "_method" : method, "password" : password, "current_password" : current_password, "password_confirmation": password_confirmation]
//        guard let hearder = UserModel.userToken else { return }
//        Loader.getInstance().show()
//        APIRouter.API_Request(typeOfCall: callType.account, params: dictionary, method: .post, authToken: hearder) { (response) in
//            Loader.getInstance().dismiss()
//            switch response {
//            case .success(let success):
//                if success.data["message"].exists() {
//                    completion (success.data["message"].stringValue)
//                }
//                return
//            case .failure(let failure):
//                self.switchFailure(failure)
//                return
//            }
//            
//        }
//    }
//    func addVechicle(categoryId: String, type : String, model:String, year: String, licene : String,
//                     images : [UIImage]? , insurances :  [UIImage]?, inspections : [UIImage]?, completion: @escaping (Bool) -> () ) {
//        let params : [String : Any] = ["category_id" : categoryId,"type" : type, "model": model, "year" : year,
//                                       "license": licene]
//        
//        guard let header = UserModel.userToken else { return }
//        var media : [Media] = []
//        if images != nil  {
//            for img in images! {
//                media.append( Media(key: "images", image: img) )
//            }
//        }
//        else if inspections != nil {
//            for imgInsp in inspections! {
//                media.append(Media(key: "inspections", image: imgInsp))
//            }
//        }
//        else if insurances != nil {
//            for imgInsu in insurances! {
//                media.append(Media(key: "insurances", image: imgInsu))
//            }
//        }
//        
//        Loader.getInstance().show()
//        APIRouter.API_Request(typeOfCall: callType.createVehicle, params: params, method: .post, authToken: header, medias : media) { (response) in
//            Loader.getInstance().dismiss()
//            switch response {
//            case .success(let success):
//                var vehicle : [VehicleModel] = []
//                for item in success.data.arrayValue {
//                    vehicle.append(VehicleModel().parse(fromJson: item))
//                    completion(true)
//                }
//            case .failure(let failure):
//                self.switchFailure(failure)
//                completion(false)
//            }
//        }
//        
//    }
//    func allDriver(completion : @escaping ([PlayerModel]) -> ()) {
//        guard let header = UserModel.userToken else {return }
//        Loader.getInstance().show()
//        APIRouter.API_Request( typeOfCall: callType.allDriver,  params: nil, method: .get , authToken: header) { (response) in
//            Loader.getInstance().dismiss()
//            switch response {
//            case .success(let success):
//                var driver : [PlayerModel] = []
//                for item in success.data.arrayValue {
//                    driver.append(PlayerModel().initialize(fromJson : item))
//                }
//                completion(driver)
//            case .failure(let failure):
//                self.switchFailure(failure)
//            }
//        }
//    }
//    func allHelper(completion : @escaping ([PlayerModel]) -> ()) {
//        guard let header = UserModel.userToken else {return }
//        Loader.getInstance().show()
//        APIRouter.API_Request( typeOfCall: callType.allHelper,  params: nil, method: .get , authToken: header) { (response) in
//            Loader.getInstance().dismiss()
//            switch response {
//            case .success(let success):
//                var helper : [PlayerModel] = []
//                for item in success.data.arrayValue {
//                    helper.append(PlayerModel().initialize(fromJson : item))
//                }
//                completion(helper)
//            case .failure(let failure):
//                self.switchFailure(failure)
//            }
//        }
//    }
//    func allVehicle(completion : @escaping ([VehicleModel]) -> ()) {
//        guard let header = UserModel.userToken else { return }
//        Loader.getInstance().show()
//        APIRouter.API_Request(typeOfCall: callType.createVehicle, method: .get , authToken: header) { (response) in
//            Loader.getInstance().dismiss()
//            switch response {
//            case .success(let success):
//                var vehicle : [VehicleModel] = []
//                for item in success.data.arrayValue {
//                    vehicle.append(VehicleModel().parse(fromJson: item))
//                }
//            case .failure(let failer):
//                self.switchFailure(failer)
//            }
//        }
//    }
//    
//    //delete images
//    func deleteImage(showById : String) {
//        guard let header = UserModel.userToken else { return }
//        let endPoint = callType.deleteImage.rawValue.appending("/\(showById)")
//        Loader.getInstance().show()
//        APIRouter.API_Request(endPoint: endPoint, method: .post, authToken: header) { (response) in
//            Loader.getInstance().dismiss()
//            switch response  {
//            case .success(let success):
//                print(success.data)
//            case .failure (let failure):
//                self.switchFailure(failure)
//            }
//        }
//    }
//    func deleteInspection(showById : String) {
//        guard let header = UserModel.userToken else { return }
//        let endPoint = callType.deleteInspection.rawValue.appending("/\(showById)")
//        Loader.getInstance().show()
//        APIRouter.API_Request(endPoint: endPoint, method: .post, authToken: header) { (response) in
//            Loader.getInstance().dismiss()
//            switch response  {
//            case .success(let success):
//                print(success.data)
//            case .failure (let failure):
//                self.switchFailure(failure)
//            }
//        }
//    }
//    func deleteInsurance(showById : String) {
//        guard let header = UserModel.userToken else { return }
//        let endPoint = callType.deleteInsurance.rawValue.appending("/\(showById)")
//        Loader.getInstance().show()
//        APIRouter.API_Request(endPoint: endPoint, method: .post, authToken: header)
//        { (response) in
//            Loader.getInstance().dismiss()
//            switch response  {
//            case .success(let success):
//                print(success.data)
//            case .failure (let failure):
//                self.switchFailure(failure)
//            }
//        }
//    }
//    
//}
