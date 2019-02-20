//
//  CheckPhoneNumberVC.swift
//  MAAKMAAK
//
//  Created by apple on 2/19/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import UIKit
import SwiftyJSON

class CheckPhoneNumberVC: UIViewController {

    @IBOutlet weak var TXTPhone: UITextField!
     var http = HttpHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        http.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func validation () -> Bool {
        var isValid = true
      
        if (TXTPhone.text?.count)! != 11  {
            Loader.showError(message: AppCommon.sharedInstance.localization("Phone number must be between 7 and 17 characters long"))
            isValid = false
        }
        
        if TXTPhone.text! == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("Phone field cannot be left blank"))
            isValid = false
        }
        
        
        return isValid
    }
    
    func CheckMobile()
    {
        if validation(){
              let params = ["mobile":"2\(TXTPhone.text!)" ] as [String: Any]
            http.GetWithoutHeader(url:APIConstants.CheckMobile , parameters: params, Tag: 1)
        }
    }

    @IBAction func Btn_Check(_ sender: Any) {
        CheckMobile()
    }
    

}


extension CheckPhoneNumberVC: HttpHelperDelegate {
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
                if result.boolValue == true
                {
                    let sb = UIStoryboard(name: "Authstory", bundle: nil)
                    let controller = sb.instantiateViewController(withIdentifier: "VerifyCodeVC") as! VerifyCodeVC
                     controller.mobile = "2\(TXTPhone.text!)"
                    controller.FalgComeFromRegister = false
                    
                    self.navigationController?.pushViewController(controller, animated: true)
                    
                }
                else
                {
                    Loader.showError(message:AppCommon.sharedInstance.localization("MobileNotExit"))
                }
               
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

