//
//  BrandsVC.swift
//  MaakMaakAPP
//
//  Created by M on 2/10/19.
//  Copyright © 2019 maakmaak. All rights reserved.
//

import UIKit
import SwiftyJSON

class BrandsVC: UIViewController {

    var items = [CarBrandModelModel]()
    var itemSelectedid:[Int] = []
    @IBOutlet weak var tblBrands: UITableView!
     var http = HttpHelper()
    
     let userid =  UserDefaults.standard.string(forKey: "UserId")!
    override func viewDidLoad() {
        super.viewDidLoad()
        http.delegate = self
        tblBrands.changeView()
        fillData()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func SaveBtn(_ sender: Any) {
        
         SaveData()
    }
    
    
    func fillData()  {
        items.removeAll()
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        print(userid)
        http.GetWithoutHeader(url:"\(APIConstants.GetProviderBrand)userId=\(userid)", Tag: 1)
    }

   
    func SaveData(){
        itemSelectedid.removeAll()
        for i in items{
            if i.isSelected == true {
                itemSelectedid.append(Int(i.carBrandId)!)
            }
        }
        if itemSelectedid.count >= 0
        {
        let params = ["UserId":userid,"Brands":itemSelectedid] as [String: Any]
        let headers = ["Content-Type": "application/json"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.SaveProviderBrand, method: .post, parameters: params, tag: 2, header: headers)
        }
    }
    


}
extension BrandsVC :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrandsCell", for: indexPath) as! BrandsCell
        
        if SharedData.SharedInstans.getLanguage() == "en"
        {
             cell.lblTitle.text = items[indexPath.row].nameEN
        }else
        {
             cell.lblTitle.text = items[indexPath.row].nameAR
        }
        
        cell.btnSwitch.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        cell.btnSwitch.tag = indexPath.row
        
        if items[indexPath.row].isSelected == true
        {
             cell.btnSwitch.isSelected = items[indexPath.row].isSelected
        }
        cell.btnSwitch.isOn = items[indexPath.row].isSelected
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    @objc func switchValueDidChange(_ sender: UISwitch) {
        items[sender.tag].isSelected = sender.isOn ? true : false
        print(items[sender.tag].carBrandId
            ,"-->",items[sender.tag].isSelected)
    }
    
}

extension BrandsVC: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        
        let json = JSON(dictResponse)
        
        let forbiddenMail : String = AppCommon.sharedInstance.localization("Error")
        if Tag == 1 {
            
            let status =  json["status"]
            let message = json["message"]
            print(status)
            print(json["status"])
            if status.stringValue  == "201" {
                let result =  json["result"].arrayValue
                for json in result{
                    let obj = CarBrandModelModel(carBrandId: json["carBrandId"].stringValue, nameAR:  json["nameAR"].stringValue, nameEN:  json["nameEN"].stringValue, isSelected:  json["isSelected"].boolValue)
                    items.append(obj)
                }
                tblBrands.reloadData()
            } else {
                Loader.showError(message: (forbiddenMail))
            }
        }
        else if Tag == 2 {
            
            let status =  json["status"]
            let message = json["message"]
            if status.stringValue  == "201" {
                Loader.showSuccess(message: AppCommon.sharedInstance.localization("done"))
                self.viewDidLoad()
            }else
            {
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



