//
//  ContactusVC.swift
//  MAAKMAAK
//
//  Created by apple on 2/21/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import UIKit
import SwiftyJSON

class ContactusVC: UIViewController {
    @IBOutlet weak var TXT_Complain: UITextView!
    var http = HttpHelper()
   
    override func viewDidLoad() {
        super.viewDidLoad()
 http.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func validation () -> Bool {
        var isValid = true

        
        if TXT_Complain.text! == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("complani field cannot be left blank"))
            isValid = false
        }
        
        return isValid
    }

    func SendComplain() {
        let userid =  UserDefaults.standard.string(forKey: "UserId")!
        let params = ["UserId":userid,"Notes":TXT_Complain.text!] as [String: Any]
        let headers = ["Content-Type": "application/json"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.ContactUS, method: .post, parameters: params, tag: 1, header: headers)
    }
    
    
    @IBAction func SendBtn(_ sender: Any) {
          if  SharedData.SharedInstans.GetIsLogin(){
        if validation() {
            SendComplain()
            }
            
          }else{
            
            AppCommon.sharedInstance.alertWith(title: "", message: AppCommon.sharedInstance.localization("Welcom"), controller: self, actionTitle: AppCommon.sharedInstance.localization("mustlogin"), actionStyle: .default, withCancelAction: false, completion: {
                let Setting = UIStoryboard(name: "Authstory", bundle: nil)
                let LoginViewController = Setting.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(LoginViewController, animated: true)
            })
        }
    }
    
}

extension ContactusVC: HttpHelperDelegate {
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
            if status.stringValue  == "200" {
              
                Loader.showSuccess(message: AppCommon.sharedInstance.localization("done"))
                }
            } else {
                
                Loader.showError(message: (forbiddenMail))
                
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

