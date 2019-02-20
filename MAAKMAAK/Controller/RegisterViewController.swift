//
//  RegisterViewController.swift
//  MaakMaakAPP
//
//  Created by M on 2/10/19.
//  Copyright © 2019 maakmaak. All rights reserved.
//

import UIKit
import SwiftyJSON

class RegisterViewController: UIViewController {
    
    var CarOwnerFalg = true
    var Carowner = 1
    var http = HttpHelper()
    @IBOutlet weak var TXTName: UITextField!
    @IBOutlet weak var TXTMobil: UITextField!
    @IBOutlet weak var TXTPassword: UITextField!
    @IBOutlet weak var TXTConfirm: UITextField!
    @IBOutlet weak var RidoBtnCar: UIButton!
    @IBOutlet weak var RidoBtnProvider: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         http.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func validation () -> Bool {
        var isValid = true
        
        
        if TXTPassword.text! != TXTConfirm.text { Loader.showError(message: AppCommon.sharedInstance.localization("Password and Confirm password is not match!"))
            isValid = false
        }
        
        if (TXTPassword.text?.count)! < 6 { Loader.showError(message: AppCommon.sharedInstance.localization("Password must be at least 6 characters long"))
            isValid = false
        }
        if TXTPassword.text! == "" { Loader.showError(message: AppCommon.sharedInstance.localization("Password field cannot be left blank"))
            isValid = false
        }
        
        
        if (TXTMobil.text?.count)! != 11  {
            Loader.showError(message: AppCommon.sharedInstance.localization("Phone number must be between 7 and 17 characters long"))
            isValid = false
        }
        
        if TXTMobil.text! == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("Phone field cannot be left blank"))
            isValid = false
        }
        if TXTName.text! == "" { Loader.showError(message: AppCommon.sharedInstance.localization("Name field cannot be left blank"))
            isValid = false
        }
        
        
        return isValid
    }
    
    
    @IBAction func ServieProviderSelecd(_ sender: UIButton) {
        CarOwnerFalg = false
        Carowner = 0
        RidoBtnProvider.setImage(UIImage(named: "radio-on-buttonActive"), for: .normal)
        RidoBtnCar.setImage(UIImage(named: "radio-on-buttonmotActive"), for: .normal)
    }
    
    @IBAction func CarOwnerSelect(_ sender: UIButton) {
        CarOwnerFalg = true
        Carowner = 1
        RidoBtnProvider.setImage(UIImage(named: "radio-on-buttonmotActive"), for: .normal)
        RidoBtnCar.setImage(UIImage(named: "radio-on-buttonActive"), for: .normal)
    }
    
    
    @IBAction func Register (_ sender: Any) {
        
        if validation(){
            print("valid")
            signup ()
        }
    }
    
    func signup () {
        let params = ["Mobile":"2\(TXTMobil.text!)","Password":TXTConfirm.text!,"UserType": Carowner,"FireBaseToken":"123"] as [String: Any]
        let headers = ["Content-Type": "application/json"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.Register, method: .post, parameters: params, tag: 1, header: headers)
    }
}


extension RegisterViewController: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
//        let userInfo = UserModule(JSON: dictResponse as! [String : Any])
        //        let forbidden : String = AppCommon.sharedInstance.localization("Duplicated user phone")
        let json = JSON(dictResponse)
          let Result =  JSON(json["result"])
        let message =  JSON(json["message"])
        let status =  JSON(json["status"])
        print(Result)
        print(message)
        print(status)
        let forbiddenMail : String = AppCommon.sharedInstance.localization("Duplicated user")
        if Tag == 1 {
            print(json["status"])
            if status.stringValue == "201" {
                print( Result["userId"].stringValue)
                print( Result["userType"].boolValue)
                 SharedData.SharedInstans.SetIsActive(Result["active"].boolValue)
               AppCommon.sharedInstance.alertWith(title: "", message: AppCommon.sharedInstance.localization("thankYouForSignup"), controller: self, actionTitle: AppCommon.sharedInstance.localization("Welcom"), actionStyle: .default, withCancelAction: false, completion: {
                    AppCommon.sharedInstance.GotoVerificationcode(vc: self,UserID:Result["userId"].stringValue,userType: Result["userType"].boolValue,Mobile:"2\(self.TXTMobil.text!)")
                })
                
                
            } else {
            
              Loader.showError(message: (forbiddenMail))
            }
        }
        
    }
    
    func receivedErrorWithStatusCode(statusCode: Int) {
        print(statusCode)
        AppCommon.sharedInstance.alert(title: "Error", message: "\(statusCode)", controller: self, actionTitle: AppCommon.sharedInstance.localization("ok"), actionStyle: .default)
        
        AppCommon.sharedInstance.dismissLoader(self.view)
    }
    
    func retryResponse(numberOfrequest: Int) {
      
    }
}
