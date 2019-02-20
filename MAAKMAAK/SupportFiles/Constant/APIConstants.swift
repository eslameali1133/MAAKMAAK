//
//  APIConstants.swift
//  CarWash
//
//  Created by Mohammad Farhan on 22/12/1710/11/17.
//  Copyright © 2017 CarWash. All rights reserved.
//

import Foundation

open class APIConstants {
   static let SERVER_URL = "http://hwsrv-434369.hostwindsdns.com/api/"
//   static let SERVER_URL = "http://192.168.1.111:8080/cartime-1.1/cartime/api/"
    
    static let Register = SERVER_URL + "users/register"
     static let SendVeriCode = SERVER_URL + "users/GenerateVRFCode"
      static let Login = SERVER_URL + "users/login"
      static let changePassword = SERVER_URL + "users/changePassword"
     static let GetProviderBrand = SERVER_URL + "ProviderAccount/GetProviderCarBrands?"
     static let SaveProviderBrand = SERVER_URL + "ProviderAccount/SaveProviderBrands"
      static let CheckMobile = SERVER_URL + "Users/CheckMobile"
    
  
    
    

}
