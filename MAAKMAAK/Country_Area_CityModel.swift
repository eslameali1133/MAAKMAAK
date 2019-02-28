//
//  Country_Area_CityModel.swift
//  MAAKMAAK
//
//  Created by apple on 2/14/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import Foundation
import UIKit

class CountryModel: NSObject {
    var id = ""
    var nameAR = ""
    var nameEN = ""
    
     init(id: String ,nameAR:String,nameEN:String) {
        self.id = id
        self.nameAR = nameAR
        self.nameEN = nameEN
    }
}

class CityModel: NSObject {
    var id = ""
    var nameAR = ""
    var nameEN = ""
     init(id:String ,nameAR:String,nameEN:String) {
        self.id = id
        self.nameAR = nameAR
        self.nameEN = nameEN
    }
}

class AreaModel: NSObject {
    var id = ""
    var nameAR = ""
    var nameEN = ""
     init(id:String ,nameAR:String,nameEN:String) {
        self.id = id
        self.nameAR = nameAR
        self.nameEN = nameEN
    }
}
