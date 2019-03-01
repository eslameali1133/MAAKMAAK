//
//  VerifyCodeVC.swift
//  MaakMaakAPP
//
//  Created by apple on 2/10/19.
//  Copyright © 2019 maakmaak. All rights reserved.
//

import UIKit
import SwiftyJSON
import KKPinCodeTextField

class VerifyCodeVC: UIViewController {

 @IBOutlet weak var txtCode: KKPinCodeTextField!
    var UserID = ""
    var UserType = false
    var mobile = ""
    var verificationCode = ""
    var FalgComeFromRegister = true
      var http = HttpHelper()
    
    @IBOutlet weak var BtnResend: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCode.addTarget(self, action: #selector(didEnd(_:)),for: .editingChanged)
        BtnResend.isEnabled = false
        http.delegate = self
        SendVerificationCode()
        // Do any additional setup after loading the view.
    }
   
    @objc func didEnd(_ textField: UITextField) {
        if textField.text?.count == 4 {
            print("/////////////////////code sent")
           self.verifyCode()
        }
    }
 
    @IBAction func Verfif_Btn(_ sender: Any) {
        
        self.verifyCode()
    }
    
    
    
    @IBAction func ResendBtn(_ sender: Any) {
        SendVerificationCode()
    }
    
    func SendVerificationCode()
    {
        print(mobile)
        let params = ["mobile":"\(mobile)"] as [String: Any]
        
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        let headers = ["": ""]
        http.GetWithoutHeader(url: APIConstants.SendVeriCode, parameters: params, Tag: 1)
    }

    
    func verifyCode(){
        if ValidCode(){
            
            SharedData.SharedInstans.SetIsLogin(true)
            UserDefaults.standard.set(UserID, forKey: "UserId")
            UserDefaults.standard.set(UserType, forKey: "UserType")
             UserDefaults.standard.set("\(mobile)", forKey: "mobile")
            
            if FalgComeFromRegister == true
            {
            AppCommon.sharedInstance.alertWith(title: "", message: AppCommon.sharedInstance.localization("Welcom"), controller: self, actionTitle: AppCommon.sharedInstance.localization("startUsingApp"), actionStyle: .default, withCancelAction: false, completion: {
               
                AppCommon.sharedInstance.ShowHome()
            })
            }else
            {
                let sb = UIStoryboard(name: "Authstory", bundle: nil)
                let controller = sb.instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
                controller.mobile = mobile
                controller.isComeFromForget = true
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    func ValidCode()->Bool{
        var falg = true
        print(verificationCode)
        print(txtCode.text! )
        if verificationCode != txtCode.text! {
            falg = false
            BtnResend.isEnabled = true
            Loader.showError(message: AppCommon.sharedInstance.localization("VerficationCodeNotValid"))
        }
        
        return falg
    }
    
   
}

extension VerifyCodeVC: HttpHelperDelegate {
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
                
                verificationCode = result.stringValue
                
                
                
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

