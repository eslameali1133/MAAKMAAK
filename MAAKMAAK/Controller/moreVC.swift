//
//  moreVC.swift
//  MaakMaakAPP
//
//  Created by apple on 2/9/19.
//  Copyright © 2019 maakmaak. All rights reserved.
//

import UIKit
import SwiftyJSON

class moreVC: MYViewController {
    
    var items = [String]()
    @IBOutlet weak var tblMoe: UITableView!
    //    @IBOutlet weak var lblItemName: UILabel!
    var register :String = AppCommon.sharedInstance.localization("register")
    var logIn :String = AppCommon.sharedInstance.localization("Log_In")
    var brands = AppCommon.sharedInstance.localization("brands")
    var services = AppCommon.sharedInstance.localization("services")
    var request = AppCommon.sharedInstance.localization("requests")
      var Logout = AppCommon.sharedInstance.localization("Logout")
    var ChangePassword = AppCommon.sharedInstance.localization("ChangePassword")
    var ContactUS = AppCommon.sharedInstance.localization("ContactUS")
    var AboutVC = AppCommon.sharedInstance.localization("AboutVC")
    var ShareA = AppCommon.sharedInstance.localization("ShareApp")
  
  
    
    var http = HttpHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        http.delegate = self
        getData()
        tblMoe.changeView()
    }
    func getData()  {
        
        if  SharedData.SharedInstans.GetIsLogin(){
              items = [brands,services,request,ChangePassword,Logout,ContactUS,AboutVC,ShareA]
        }else
        {
         
                items = [register,logIn,brands,services,request,ContactUS,AboutVC,ShareA]
        }
        
      
    }
    
    func logout(){
      
        let userid =  UserDefaults.standard.string(forKey: "UserId")!
        let params = ["UserId": userid] as [String: Any]
        let headers = ["Content-Type": "application/json"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.LogOut, method: .post, parameters: params, tag: 1, header: headers)
    }
    
    func ShareApp()
    {
        let myWebsite = NSURL(string:"http://www.google.com/")
        guard let url = myWebsite else {
            print("nothing found")
            return
        }
        let shareItems:Array = [url]
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo]
        self.present(activityViewController, animated: true, completion: nil)
        
        
    }
    
}
extension moreVC :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell", for: indexPath) as! MoreCell
        cell.lblItemName.text = items[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if SharedData.SharedInstans.GetIsLogin()
        {
            
            switch indexPath.row {
                   case 0:
                let Setting = UIStoryboard(name: "HomeVender", bundle: nil)
                let BrandsVC = Setting.instantiateViewController(withIdentifier: "BrandsVC") as! BrandsVC
                self.navigationController?.pushViewController(BrandsVC, animated: true)
            case 1:
                let Setting = UIStoryboard(name: "HomeVender", bundle: nil)
                let ServiceVC = Setting.instantiateViewController(withIdentifier: "ServiceVC") as! ServiceVC
                self.navigationController?.pushViewController(ServiceVC, animated: true)
            case 2:
                let Setting = UIStoryboard(name: "HomeVender", bundle: nil)
                let ServiceVC = Setting.instantiateViewController(withIdentifier: "RequestsVC") as! RequestsVC
                self.navigationController?.pushViewController(ServiceVC, animated: true)
            case 3:
                let Setting = UIStoryboard(name: "Authstory", bundle: nil)
                let ServiceVC = Setting.instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
                ServiceVC.isComeFromForget = false
                self.navigationController?.pushViewController(ServiceVC, animated: true)
            case 4:
         logout()
                
            case 5:
                let Setting = UIStoryboard(name: "About", bundle: nil)
                let ServiceVC = Setting.instantiateViewController(withIdentifier: "ContactusVC") as! ContactusVC
                self.navigationController?.pushViewController(ServiceVC, animated: true)
            case 6:
                let Setting = UIStoryboard(name: "About", bundle: nil)
                let ServiceVC = Setting.instantiateViewController(withIdentifier: "AboutVC") as! AboutVC
                self.navigationController?.pushViewController(ServiceVC, animated: true)
            case 7:
                ShareApp()
            default:
                break
            }
            
            
        }
        else {
            
           
            switch indexPath.row {
            case 0:
                let Setting = UIStoryboard(name: "Authstory", bundle: nil)
                let accountVC = Setting.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
                self.navigationController?.pushViewController(accountVC, animated: true)
            case 1:
                let Setting = UIStoryboard(name: "Authstory", bundle: nil)
                let LoginViewController = Setting.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(LoginViewController, animated: true)
            case 2:
                let Setting = UIStoryboard(name: "HomeVender", bundle: nil)
                let BrandsVC = Setting.instantiateViewController(withIdentifier: "BrandsVC") as! BrandsVC
                self.navigationController?.pushViewController(BrandsVC, animated: true)
            case 3:
                let Setting = UIStoryboard(name: "HomeVender", bundle: nil)
                let ServiceVC = Setting.instantiateViewController(withIdentifier: "ServiceVC") as! ServiceVC
                self.navigationController?.pushViewController(ServiceVC, animated: true)
            case 4:
                let Setting = UIStoryboard(name: "HomeVender", bundle: nil)
                let ServiceVC = Setting.instantiateViewController(withIdentifier: "RequestsVC") as! RequestsVC
                self.navigationController?.pushViewController(ServiceVC, animated: true)
            case 5:
                let Setting = UIStoryboard(name: "About", bundle: nil)
                let ServiceVC = Setting.instantiateViewController(withIdentifier: "ContactusVC") as! ContactusVC
                self.navigationController?.pushViewController(ServiceVC, animated: true)
            case 6:
                let Setting = UIStoryboard(name: "About", bundle: nil)
                let ServiceVC = Setting.instantiateViewController(withIdentifier: "AboutVC") as! AboutVC
                self.navigationController?.pushViewController(ServiceVC, animated: true)
                
            case 7:
                ShareApp()
            default:
                break
            }
            
            
        }
    }
    
}


extension moreVC: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        
        let json = JSON(dictResponse)
        
        let forbiddenMail : String = AppCommon.sharedInstance.localization("Error")
        if Tag == 1 {
            
            let status =  json["status"]
            
            print(status)
            print(json["status"])
            if status.stringValue  == "201" {
                  items = [register,logIn,brands,services,request,ContactUS,AboutVC,ShareA]
                  SharedData.SharedInstans.SetIsLogin(false)
                _ = UserDefaults.standard.removeObject(forKey: "UserId")
                
               tblMoe.reloadData()
                 AppCommon.sharedInstance.ShowHome()
                
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
