//
//  VenderProfileMOdel.swift
//  MAAKMAAK
//
//  Created by apple on 2/20/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import Foundation

import UIKit

class VendorProfileModel: NSObject {
    var userId = ""
    var mobile = ""
    var rate = 0
    var image = ""
    var email = ""
    
    var companyName = ""
    var cityId = ""
    var areaId = ""
    var countryId = ""
    
    var latitude = ""
    var longitude = ""
    var contactPerson = ""

    init(userId:String , mobile:String ,email:String ,rate:Int ,image:String,  companyName:String , cityId:String ,areaId:String ,countryId:String,
           latitude:String ,longitude:String ,contactPerson:String) {
       
        self.userId = userId
        self.mobile = mobile
        self.rate = rate
        self.image = image
        self.companyName = companyName
        self.cityId = cityId
        self.areaId = areaId
        self.countryId = countryId
        
        self.latitude = latitude
        self.longitude = longitude
        self.contactPerson = contactPerson
        self.email = email
        
    }
}
