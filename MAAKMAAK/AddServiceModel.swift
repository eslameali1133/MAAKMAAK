//
//  AddServiceModel.swift
//  MAAKMAAK
//
//  Created by apple on 3/3/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class AddServiceModel: NSObject {

    class func ServiceTypes(serviceid:Int, completion: @escaping (_ error: Error?, _ success: Bool ,_ message:[ServiceType]?)->Void){
        var url = (APIConstants.ServiceType).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if serviceid != -1 {
            url = (APIConstants.GetAllServices+"serviceTypeId=\(serviceid)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        }
        Alamofire.request(url!, method: .get, parameters:nil, encoding: URLEncoding.default, headers: nil)
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
                    guard let resDataArr = dict?["result"]?.array
                        else {
                            completion(nil, false ,nil)
                            return
                    }
                    var ServiceTypes = [ServiceType]()
                    
                    for resServiceType in resDataArr {
                        guard let resService = resServiceType.dictionary
                            else {
                                completion(nil, false ,nil)
                                return
                        }
                        let serviceType = ServiceType(id: resService["id"]?.int ?? 0,
                                                      nameEN: resService["nameEN"]?.string ?? "",
                                                      nameAR: resService["nameAR"]?.string ?? "",
                                                      notes: resService["notes"]?.string ?? "")
                        ServiceTypes.append(serviceType)
                    }
                    completion(nil, true ,ServiceTypes)
                }
        }
    }
}
class ServiceType {
    var id : Int?
    var nameEN : String?
    var nameAR : String?
    var notes : String?
    init(id : Int,nameEN : String,nameAR : String,notes : String) {
        self.id = id
        self.nameEN = nameEN
        self.nameAR  = nameAR
        self.notes = notes
    }
}


