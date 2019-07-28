//
//  NetworkingManager.swift
//  Train60
//
//  Created by Bilal on 23/07/2019.
//  Copyright © 2019 Bilal. All rights reserved.
//

import Foundation
import SwiftyJSON


enum AppURL : String {
    
    case TermsAndConditions = ""
    case PrivacyPolicy = "as"
}

let apiURL = "http://api.openweathermap.org/data/2.5/forecast?id=1275339&APPID=39d3df86cda45bf4394dbeb18fa015d9"

typealias completionBlock = (_ response : ServerResponse) -> Void

public enum callType : String {
    // Account
    case account = "/api/login"
    case oauthToken = "/oauth/token"
    
    
}

enum httpMethod:String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case del = "DELETE"
}

enum responseState {
    
    case failure
    case authError
    case unknown
    case networkIssue
    case timeOut
    case notVerified
}

struct APIRouter {
//
//    func decode<T>(modelType: T.Type, data: Data) where T : Decodable {
//        let myStruct = try! JSONDecoder().decode(modelType, from: data)
//        print(myStruct)
//    }
    
    
    static func urlRequest<T>(modelType: T.Type, urlString: String) where T : (Decodable) {
    
//        let jsonUrlString = "http://api.openweathermap.org/data/2.5/forecast?id=1275339&APPID=39d3df86cda45bf4394dbeb18fa015d9"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //perhaps check err
            //also perhaps check response status 200 OK
            
            guard let data = data else { return }
            
            //            let dataAsString = String(data: data, encoding: .utf8)
            //            print(dataAsString)
            
            do {
                
                
                
                let myStruct = try JSONDecoder().decode(modelType, from: data)
                print(myStruct)
//                print(weatherInfo.cod, weatherInfo.message)
//                print(weatherInfo.list[0].wind.deg)
//                print(weatherInfo.list[0].wind.speed)
                
                
                //                    let courses = try JSONDecoder().decode([Course].self, from: data)
                //                    print(courses)
                
                //Swift 2/3/ObjC
                //                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                //
                //                let course = Course(json: json)
                //                print(course.name)
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
            
            
            }.resume()
    
    
    }
    
    
    static func API_Request(completeUrl:String? = nil, typeOfCall : callType? = nil, endPoint: String? = nil, params: [String:Any]? = [:], method: httpMethod = .get,authToken : String? = nil, media: Media? = nil, medias: [Media] = [] , completion: @escaping completionBlock)
        
    {
        var urlString = ""
        if let completeUrlString = completeUrl {
            urlString = completeUrlString
        } else if let type = typeOfCall {
            urlString = apiURL.appending("\(type.rawValue)")
        } else if let endPointString = endPoint {
            urlString = apiURL.appending(endPointString)
        } else {
            let errorResponse = ServerResponse.failure(Failure(message: "URL endPoint is not correct.", code: .networkIssue))
            completion(errorResponse)
            return
        }
        
        let url = URL(string: urlString)
        print("URL: \(urlString)")
        let session = URLSession.shared
        
        var request = URLRequest(url: url! , cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 12.0)
        
        request.httpMethod = method.rawValue
        
        if authToken != nil {
            print("AuthToken \(authToken!)")
            request.addValue("\(authToken!)", forHTTPHeaderField: "Authorization")
        }
        
        
        if ( media != nil || medias.count > 0) {
            
            let boundary = "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = createBody(parameters: params ?? [:],
                                          boundary: boundary,
                                          media: media,
                                          medias: medias)
        } else if params != nil {
            print("Params \(params!)")
            let tempData = (params!.flatMap({ (key, value) -> String in
                return "\(key)=\(value)"
            }) as Array).joined(separator: "&")
            
            request.httpBody = tempData.data(using: .utf8)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        //        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        if !UIUtility.isInternetAvailable(){
            let errorResponse = ServerResponse.failure(Failure(message: "Please check your internet connection.", code: .networkIssue))
            completion(errorResponse)
            return
        }
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                if error?._code == NSURLErrorTimedOut {
                    
                    let errorResponse = ServerResponse.failure(Failure(message: "Request timed out.", code: .timeOut))
                    completion(errorResponse)
                }
                else if error?._code == NSURLErrorNotConnectedToInternet || error?._code == NSURLErrorNetworkConnectionLost{
                    
                    let errorResponse = ServerResponse.failure(Failure(message: "Please check your internet connection.", code: .networkIssue))
                    completion(errorResponse)
                    
                } else {
                    let errorResponse = ServerResponse.failure(Failure(message: "Sorry, something went wrong.", code: .unknown))
                    completion(errorResponse)
                }
                return
            }
            
            guard let data = data else {
                
                let errorResponse = ServerResponse.failure(Failure(message: "Sorry, something went wrong.", code: .unknown))
                completion(errorResponse)
                return
            }
            
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse!.statusCode)
            
            do {
                let jsonResult: Any = (try JSONSerialization.jsonObject(with: data, options:
                    JSONSerialization.ReadingOptions.mutableContainers))
                
                let json = JSON(jsonResult)
                
                if let error = json["error"].string{
                    let errorResponse = ServerResponse.failure(Failure(message: error, code: .failure))
                    
                    completion(errorResponse)
                } else if json["error"].stringValue == "Unauthenticated" {
                    let errorResponse = ServerResponse.failure(Failure(message: json["error"].stringValue, code: .authError))
                    
                    completion(errorResponse)
                } else if let status = json["status"].bool, status == false {
                    let errorResponse = ServerResponse.failure(Failure(message: json["message"].stringValue, code: .failure))
                    
                    completion(errorResponse)
                } else {
                    if let response = httpResponse, response.statusCode >= 200 && response.statusCode < 300 {
                        print("Success Response:\(json) ")
                        let success = ServerResponse.success(Success(json))
                        completion(success)
                    } else {
                        
                        let errorResponse = ServerResponse.failure(Failure(message: json["message"].stringValue, code: .failure, data: json))
                        completion(errorResponse)
                    }
                }
            } catch _ {
                let errorResponse = ServerResponse.failure(Failure(message: "Sorry, something went wrong.", code: .unknown))
                
                completion(errorResponse)
            }
        })
        
        task.resume()
    }
    static func createBody(parameters: [String: Any],
                           boundary: String,
                           media: Media? = nil,
                           medias: [Media] = []) -> Data {
        
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            print("Params \(key) : \(value)")
            
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        if let mediaObj = media  {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(mediaObj.key)\"; filename=\"\(mediaObj.filename)\"\r\n")
            body.appendString("Content-Type: \(mediaObj.mimeType)\r\n\r\n")
            body.append(mediaObj.data)
            body.appendString("\r\n")
            body.appendString("--".appending(boundary.appending("--")))
            
        } else if medias.count > 0 {
            
            for (i,media) in medias.enumerated() {
                
                body.appendString(boundaryPrefix)
                body.appendString("Content-Disposition: form-data; name=\"\(media.key)[\(i)]\"; filename=\"\(media.filename)\"\r\n")
                body.appendString("Content-Type: \(media.mimeType)\r\n\r\n")
                body.append(media.data)
                body.appendString("\r\n")
            }
            body.appendString("--".appending(boundary.appending("--")))
            
        } else {
            print("Images are not provided...")
        }
        
        return body as Data
    }
    
}

struct Success {
    
    var data : JSON
    
    init(_ data : JSON) {
        self.data = data
    }
}
struct Failure {
    var message : String
    var code : responseState
    var data : JSON?
    
    init(message: String , code: responseState, data: JSON? = nil) {
        self.message = message
        self.code = code
        self.data = data
    }
}
enum ServerResponse {
    case success (Success)
    case failure (Failure)
}
extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
class Media {
    
    var key : String
    var data : Data
    var mimeType: String
    var filename : String
    
    init (key : String, image: UIImage, mimeType : String = "", filename: String = "image") {
        
        self.key = key
        self.filename = filename
        self.mimeType = mimeType
        
        if let image =  UIImageJPEGRepresentation(image, 0.4) //image.jpegData(compressionQuality: 0.4)
        {
            self.data = image
            self.mimeType = mimeType == "" ? "image/jpg" : mimeType
        } else
            if let image = UIImagePNGRepresentation(image)  {
                self.data = image
                self.mimeType = mimeType == "" ? "image/png" : mimeType
            } else {
                data = Data()
        }
        
    }
    init(key : String, video: Data, mimeType : String, filename : String = "video") {
        self.key = key
        self.data = video
        self.mimeType = mimeType
        self.filename = filename
    }
    
}
