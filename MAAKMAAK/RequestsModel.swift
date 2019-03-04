//
//  RequestsModel.swift
//  MAAKMAAK
//
//  Created by M on 3/2/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class RequestsModel: NSObject {
    
    class func getRequests(userId:String, completion: @escaping (_ error: Error?, _ success: Bool ,_ message:String?, _ data: [[AllRequests]]?)->Void)  {
        //.//
        let url = (APIConstants.Order+"userId=\(userId)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        Alamofire.request(url!, method: .get, parameters:nil, encoding: URLEncoding.default, headers: nil)
            //.validate(statusCode: 200..<300)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, false ,nil,nil)
                    print("////////////////////////////////////////////////////////",error)
                    
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    guard let resDataArr = json["result"].dictionary
                        else {
                            completion(nil, false ,nil,nil)
                            return
                    }
                    var all = [[AllRequests]]()
                    var listIndex = 0
                    var listType = ["pendingList","inProgressList","historyList"]
                    for _ in 1...3 {
                        guard let resServiceTypes = resDataArr[listType[listIndex]]!.dictionary
                            else {
                                completion(nil, false ,nil,nil)
                                return
                        }
                        var serviceIndex = 0
                        var serviceType = ["carServiceOrders","accidentOrders","emergencyOrders"]
                        var allRequestsTypes = [AllRequests]()
                        for _ in 1...3 {
                            guard let resServiceTypes = resServiceTypes[serviceType[serviceIndex]]!.array
                                else {
                                    completion(nil, false ,nil,nil)
                                    return
                            }
                            var Services = [RequestServices]()
                            for resService in resServiceTypes {
                                guard let resService = resService.dictionary
                                    else {
                                        completion(nil, false ,nil,nil)
                                        return
                                }
                                let Service = RequestServices(orderId: resService["orderId"]?.int ?? 0,
                                                              customerName: resService["customerName"]?.string ?? "",
                                                              carBrandEN: resService["carBrandEN"]?.string ?? "",
                                                              carBrandAR: resService["carBrandAR"]?.string ?? "",
                                                              carModelEN: resService["carModelEN"]?.string ?? "",
                                                              carModelAR: resService["carModelAR"]?.string ?? "",
                                                              serviceTypeNameEN: resService["serviceTypeNameEN"]?.string ?? "",
                                                              serviceNameEN: resService["serviceNameEN"]?.string ?? "",
                                                              serviceTypeNameAR: resService["serviceTypeNameAR"]?.string ?? "",
                                                              creationDate: resService["creationDate"]?.string ?? "",
                                                              longitude: resService["longitude"]?.string ?? "",
                                                              contactPerson: resService["contactPerson"]?.string ?? "")
                                Services.append(Service)
                            }
                            let request = AllRequests(Section: serviceIndex,
                                                          SectionType: serviceType[serviceIndex],
                                                          services: Services)
                           
                            allRequestsTypes.append(request)
                            
                          serviceIndex += 1
                        }
//                        let request =
                        
                       all.append(allRequestsTypes)
                       listIndex += 1
                    }
                    completion(nil,true ,nil,all)
                }
                
                
                //completion(nil, tasks, last_page)
        }
    }
    class func acceptRequest(orderId:Int, completion: @escaping (_ error: Error?, _ success: Bool ,_ message:String?)->Void)  {
        //.//
        
        let url = (APIConstants.AcceptOrder+"orderId=\(orderId)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        Alamofire.request(url!, method: .post, parameters:nil, encoding: URLEncoding.default, headers: nil)
            //.validate(statusCode: 200..<300)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, false ,nil)
                    print("////////////////////////////////////////////////////////",error)
                    
                case .success(let value):
                    let json = JSON(value)
                    let dict = json.dictionary
                    print(json)
                    guard let resDataArr = dict?["message"]?.string
                        else {
                            completion(nil, false ,nil)
                            return
                    }
                   completion(nil, false ,resDataArr)
                }
                
        }
    
    }
    class func rejectRequest(orderId:Int, completion: @escaping (_ error: Error?, _ success: Bool ,_ message:String?)->Void)  {
        //.//
        
        let url = (APIConstants.RejectOrder+"orderId=\(orderId)&reasonId=1").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        Alamofire.request(url!, method: .post, parameters:nil, encoding: URLEncoding.default, headers: nil)
            //.validate(statusCode: 200..<300)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, false ,nil)
                    print("////////////////////////////////////////////////////////",error)
                    
                case .success(let value):
                    let json = JSON(value)
                    let dict = json.dictionary
                    print(json)
                    guard let resDataArr = dict?["message"]?.string
                        else {
                            completion(nil, false ,nil)
                            return
                    }
                    completion(nil, false ,resDataArr)
                }
                
        }
        
    }
    
}
class RequestServices: NSObject {
    var orderId :Int?
    var customerName :String?
    var carBrandEN :String?
    var carBrandAR :String?
    var carModelEN :String?
    var carModelAR :String?
    var serviceTypeNameEN :String?
    var serviceNameEN :String?
    var serviceTypeNameAR :String?
    var serviceNameAR :String?
    var creationDate :String?
    init(orderId:Int , customerName:String ,carBrandEN:String ,carBrandAR:String ,carModelEN:String,  carModelAR:String , serviceTypeNameEN:String ,serviceNameEN:String ,serviceTypeNameAR:String,
         creationDate:String ,longitude:String ,contactPerson:String) {
        
        self.orderId = orderId
        self.customerName = customerName
        self.carBrandEN = carBrandEN
        self.carBrandAR = carBrandAR
        self.carModelEN = carModelEN
        self.carModelAR = carModelAR
        self.serviceTypeNameEN = serviceTypeNameEN
        self.serviceNameEN = serviceNameEN
        
        self.serviceNameEN = serviceNameEN
        self.serviceTypeNameAR = serviceTypeNameAR
        self.creationDate = creationDate
        
        
    }
}
class AllRequests {
    var Section:Int
    var SectionType:String?
    var services : [RequestServices]?
    init(Section:Int,SectionType:String,services : [RequestServices]) {
        self.Section = Section
        self.SectionType = SectionType
        self.services = services
    }
}
