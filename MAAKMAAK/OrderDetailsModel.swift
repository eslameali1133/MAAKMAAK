//
//  OrderDetailsModel.swift
//  MAAKMAAK
//
//  Created by apple on 3/3/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class OrderDetailsModel: NSObject {

    class func getOrderDetails(orderId:Int, completion: @escaping (_ error: Error?, _ success: Bool ,_ message:OrderData?)->Void){
        let url = (APIConstants.GetOrderDetails+"orderId=\(orderId)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
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
                    
                    print(json)
                    guard let resDataArr = json["result"]["orderDetails"].array
                        else {
                            completion(nil, false ,nil)
                            return
                    }
                    guard let resOrder = json["result"]["order"].dictionary
                        else {
                            completion(nil, false ,nil)
                            return
                    }
                    guard let resOrderImages = json["result"]["orderImages"].arrayObject
                        else {
                            completion(nil, false ,nil)
                            return
                    }
                    let orderBase = OrderBase(orderId: resOrder["orderId"]?.int ?? 0,
                                              customerName: resOrder["customerName"]?.string ?? "",
                                              orderTypeAR: resOrder["orderTypeAR"]?.string ?? "",
                                              notes: resOrder["notes"]?.string ?? "",
                                              orderTypeEN: resOrder["orderTypeEN"]?.string ?? "",
                                              orderTypeId: resOrder["orderTypeId"]?.int ?? 0,
                                              creationDate: resOrder["creationDate"]?.string ?? "",
                                              customerMobile: resOrder["customerMobile"]?.string ?? "",
                                              latitude: resOrder["latitude"]?.double ?? 0.0,
                                              longitude: resOrder["longitude"]?.double ?? 0.0,
                                              customerNote: resOrder["customerNote"]?.string ?? "",
                                              carBrandNameAR: resOrder["carBrandNameAR"]?.string ?? "",
                                              carBrandNameEN: resOrder["carBrandNameEN"]?.string ?? "",
                                              carModelNameEN: resOrder["carModelNameEN"]?.string ?? "",
                                              carModelNameAR: resOrder["carModelNameAR"]?.string ?? "")
                    var OrderDetailsArr = [OrederDetails]()
                    for resOrderDets in resDataArr {
                        guard let resOrder = resOrderDets.dictionary
                            else {
                                completion(nil, false ,nil)
                                return
                        }
                        let order = OrederDetails(id: resOrder["id"]?.int ?? 0,
                                                  serviceNameAR: resOrder["serviceNameAR"]?.string ?? "",
                                                  serviceNameEN: resOrder["serviceNameEN"]?.string ?? "",
                                                  serviceTypeNameAR: resOrder["serviceTypeNameAR"]?.string ?? "",
                                                  serviceTypeNameEN: resOrder["serviceTypeNameEN"]?.string ?? "",
                                                  price: resOrder["price"]?.int ?? 0)
                        
                        
                        OrderDetailsArr.append(order)
                    }
                    var orderImages = [OrderImages]()
                    
                    for image in resOrderImages {
                        let images = OrderImages(Image: image as! String)
                        orderImages.append(images)
                    }
                    let orderData = OrderData(orderBase: orderBase,
                                              orderImges: orderImages,
                                              orderDetails: OrderDetailsArr)
                    completion(nil, true ,orderData)
                }
        }
    }

}
class OrderData {
    var orderBase :OrderBase?
    var orderImges :[OrderImages]?
    var orderDetails :[OrederDetails]?
    init(orderBase :OrderBase,orderImges :[OrderImages],orderDetails :[OrederDetails]) {
        self.orderBase = orderBase
        self.orderImges = orderImges
        self.orderDetails = orderDetails
    }
}
class OrderBase {
    var orderId : Int?
    var customerName :String?
    var orderTypeAR : String?
    var orderTypeEN : String?
    var orderTypeId :Int?
    var creationDate :String?
    var notes :String?
    var customerMobile:String?
    var latitude :Double?
    var longitude :Double?
    var customerNote :String?
    var carBrandNameAR :String?
    var carBrandNameEN :String?
    var carModelNameEN :String?
    var carModelNameAR :String?

    
    init(orderId : Int,customerName : String,orderTypeAR : String,notes : String,orderTypeEN : String,orderTypeId :Int,creationDate :String,customerMobile:String,latitude :Double,longitude :Double,customerNote :String,carBrandNameAR :String,carBrandNameEN :String,carModelNameEN :String,carModelNameAR:String) {
        self.orderId = orderId
        self.customerName = customerName
        self.orderTypeAR  = orderTypeAR
        self.orderTypeEN = orderTypeEN
        self.orderTypeId = orderTypeId
        self.creationDate = creationDate
        self.customerMobile = customerMobile
        self.latitude = latitude
        self.longitude = longitude
        self.customerNote = customerNote
        self.carBrandNameAR = carBrandNameAR
        self.carBrandNameEN = carBrandNameEN
        self.carModelNameEN = carModelNameEN
        self.carModelNameAR = carModelNameAR
        self.notes = notes
        
    }
   
}

class OrederDetails{
    var id :Int?
    var serviceNameAR :String?
    var serviceNameEN :String?
    var serviceTypeNameAR :String?
    var serviceTypeNameEN :String?
    var price :Int?
    init(id :Int,serviceNameAR :String,serviceNameEN :String,serviceTypeNameAR :String,serviceTypeNameEN :String,price :Int) {
        self.id = id
        self.serviceNameAR = serviceNameAR
        self.serviceNameEN = serviceNameEN
        self.serviceTypeNameAR = serviceTypeNameAR
        self.serviceTypeNameEN = serviceTypeNameEN
        self.price = price
    }
}
class OrderImages {
    var Image :String?
    init(Image :String) {
        self.Image = Image
    }
}









