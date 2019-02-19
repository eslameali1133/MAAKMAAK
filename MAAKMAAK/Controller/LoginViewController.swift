//
//  LoginViewController.swift
//  MaakMaakAPP
//
//  Created by M on 2/9/19.
//  Copyright © 2019 maakmaak. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var TXTMobil: UITextField!
    @IBOutlet weak var TXTPassword: UITextField!
    var http = HttpHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        http.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BtnLogin(_ sender: Any) {
        if validation(){
            Login()
        }
    }
    
    func validation () -> Bool {
        var isValid = true
        
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
       
        
        return isValid
    }
   
    func Login() {
        let params = ["Mobile":"2\(TXTMobil.text!)","Password":TXTPassword.text!,"FireBaseToken":"123" ] as [String: Any]
        let headers = ["Content-Type": "application/json"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.Login, method: .post, parameters: params, tag: 1, header: headers)
    }
    
}

extension LoginViewController: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        
        let json = JSON(dictResponse)
        
        let forbiddenMail : String = AppCommon.sharedInstance.localization("Error")
        if Tag == 1 {
            
            let status =  json["status"]
            let message = json["message"]
            let result =  json["result"]
              let Result =  JSON(json["result"])
            print(result)
            print(message)
            print(status)
            
            print(json["status"])
            if status.stringValue  == "201" {
                SharedData.SharedInstans.SetIsLogin(true)
                
                UserDefaults.standard.set(Result["userId"].stringValue, forKey: "UserId")
                UserDefaults.standard.set(Result["userType"].stringValue, forKey: "UserType")
                UserDefaults.standard.set("2\(TXTMobil.text!)", forKey: "mobile")
                AppCommon.sharedInstance.alertWith(title: "", message: AppCommon.sharedInstance.localization("Welcom"), controller: self, actionTitle: AppCommon.sharedInstance.localization("startUsingApp"), actionStyle: .default, withCancelAction: false, completion: {
                    AppCommon.sharedInstance.ShowHome()
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

