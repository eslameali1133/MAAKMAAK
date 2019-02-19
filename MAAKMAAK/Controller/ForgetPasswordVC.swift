//
//  ForgetPasswordVC.swift
//  MaakMaakAPP
//
//  Created by apple on 2/10/19.
//  Copyright © 2019 maakmaak. All rights reserved.
//

import UIKit
import  SwiftyJSON

class ForgetPasswordVC: UIViewController {

    @IBOutlet weak var TXTPassword: UITextField!
    @IBOutlet weak var TXTConfirm: UITextField!
    var mobile = ""
     var http = HttpHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        if  SharedData.SharedInstans.GetIsLogin(){
            mobile =  UserDefaults.standard.string(forKey: "mobile")!
            print (mobile)
        }
        
        http.delegate = self
        // Do any additional setup after loading the view.
        print(12)
    }
    
    @IBAction func BtnChange(_ sender: Any) {
        if validation(){
           chnagepassword()
        }
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
        
    
        return isValid
    }
    
    func chnagepassword() {
        let params = ["Mobile":mobile,"Password":TXTPassword.text!] as [String: Any]
        let headers = ["Content-Type": "application/json"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.changePassword, method: .post, parameters: params, tag: 1, header: headers)
    }

}

extension ForgetPasswordVC: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        
        let json = JSON(dictResponse)
        
        let forbiddenMail : String = AppCommon.sharedInstance.localization("Error")
        if Tag == 1 {
            
            let status =  json["status"]
            let message = json["message"]
            let result =  json["result"]
           
            print(result)
            print(message)
            print(status)
            
            print(json["status"])
            if status.stringValue  == "201" {
                Loader.show(success: true)
                
            
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


