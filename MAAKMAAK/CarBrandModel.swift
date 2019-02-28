//
//  CarBrandModel.swift
//  MAAKMAAK
//
//  Created by apple on 2/18/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import Foundation
import UIKit

class CarBrandModelModel: NSObject {
    var carBrandId = ""
    var nameAR = ""
    var nameEN = ""
     var isSelected = false
     init(carBrandId:String , nameAR:String ,nameEN:String ,isSelected:Bool ) {
        self.carBrandId = carBrandId
         self.nameAR = nameAR
        self.nameEN = nameEN
         self.isSelected = isSelected
    }
}
