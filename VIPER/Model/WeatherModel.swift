import Foundation
import SwiftyJSON

class WeatherModel {
    
    var cnt : Int?
    var message : Double?
    var cod : String?
    var list: [List]?
    
    
    
    init() {
    
    }
    
    init(json : JSON){
        let obj = WeatherModel()
        obj.cnt = json["cnt"].intValue
        obj.message = json["message"].doubleValue
        obj.cod = json["cod"].stringValue
        
        if json["list"].exists() {
            
            for listObj in json["list"].arrayValue {
            
                print(listObj)
            }
            
        }
    }
    
}

//class List {
//    
//    var dt: String?
//    
//    init() {
//        
//    }
//    
//    init(json: JSON) {
//        dt = json["dt_txt"].stringValue
//        print(dt)
//    }
//    
//    
//}
