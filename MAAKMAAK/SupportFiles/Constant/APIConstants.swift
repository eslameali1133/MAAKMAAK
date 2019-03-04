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
    static let GetVenderProfile = SERVER_URL + "ProviderAccount/GetProfile"
    static let SaveVenderProfile = SERVER_URL + "ProviderAccount/SaveProfile"
    static let GetCountry = SERVER_URL + "Country/GetAllCountry"
    static let GetCity = SERVER_URL + "City/GetAllCity"
    static let GetArea = SERVER_URL + "Area/GetAllAreas"
    static let ContactUS = SERVER_URL + "ContactUs/SaveContactUs"
    static let LogOut = SERVER_URL + "users/Logout"
    static let Order = SERVER_URL + "Order/GetOrders?"
    static let AcceptOrder = SERVER_URL + "OrderStatus/AcceptOrder?"
    static let RejectOrder = SERVER_URL + "OrderStatus/RejectOrder?"
    static let ServiceType = SERVER_URL + "ServiceType/GetAllServiceTypes"
    static let GetAllServices = SERVER_URL + "Services/GetAllServices?"
    static let GetOrderDetails = SERVER_URL + "Order/GetOrderDetails?"
}
