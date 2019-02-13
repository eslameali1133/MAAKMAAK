//
//  APIConstants.swift
//  CarWash
//
//  Created by Mohammad Farhan on 22/12/1710/11/17.
//  Copyright © 2017 CarWash. All rights reserved.
//

import Foundation

open class APIConstants {
   static let SERVER_URL = "http://162.144.158.192:8080/cartime-1.1/cartime/api/"
//   static let SERVER_URL = "http://192.168.1.111:8080/cartime-1.1/cartime/api/"
    static let SetRate = SERVER_URL + "rate"
    static let LOGIN = SERVER_URL + "user/login"
    static let SIGN_UP = SERVER_URL + "user"
    static let FORGET_PASSWORD = SERVER_URL + "user/forget"
    static let GET_CAR = SERVER_URL + "car"
    
    static let OIL_TYPE = SERVER_URL + "oiltype"
    static let CAR_MODEL = SERVER_URL + "carmodel"
    static let CAR_BRAND = SERVER_URL + "carbrand"
    static let CAR_SIZE = SERVER_URL + "carsize"
    static let WASH_METHOD = SERVER_URL + "carwashmethod"
    static let WASH_TYPE = SERVER_URL + "carwashtype"

    static let CALCULATE_PRICE = SERVER_URL + "request/calculate"
    static let EDIT_USER = SERVER_URL + "user"
    static let CAR_WASH = SERVER_URL + "carwashrequest"
    static let OIL_CHANGE = SERVER_URL + "oilchangerequest"
    static let OIL_CHANGE_PRICE = SERVER_URL + "oilchangerequest/price"
    static let CAR_WASH_PRICE = SERVER_URL + "carwashrequest/price"
    static let HISTORY = SERVER_URL + "user/history"
///user/availableTimes?date=25.05.2015
    static let DELETE_CARWASH_HISTORY = SERVER_URL + "carwashrequest/delete"
    static let DELETE_CHANGEOIL_HISTORY = SERVER_URL + "oilchangerequest/delete"

    static let OIL_CHANGE_TIMES = SERVER_URL + "user/availableTimes"
    static let CAR_WASH_TIMES = SERVER_URL + "user/availableTimes"

}
