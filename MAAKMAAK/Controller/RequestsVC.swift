//
//  RequestsVC.swift
//  MAAKMAAK
//
//  Created by M on 2/13/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import UIKit
import SwiftyJSON
class RequestsVC: UIViewController {

    var requestsData = [allRequests]()
    
    @IBOutlet weak var tblRequests: UITableView!
    var status = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRequests()
        tblRequests.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        tblRequests.register(RequestCell.nib, forCellReuseIdentifier: RequestCell.identifier)
        tblRequests.register(RequestProgressCell.nib, forCellReuseIdentifier: RequestProgressCell.identifier)
        tblRequests.register(RequestInvoiceCell.nib, forCellReuseIdentifier: RequestInvoiceCell.identifier)
        // Do any additional setup after loading the view.
    }
    func getRequests(){
//        requestsData.append(allRequests()
        requestsData.append(allRequests(sectionTitle: "Accedent1",section: 0, collapsed :false, request: [request(name: "Taha", brand: "Mercedes", service: "Car Moing", time: "9/9/2018 2:00")
            ,request(name: "Taha", brand: "Mercedes", service: "Car Moing", time: "9/9/2018 2:00")
            ,request(name: "Taha", brand: "Mercedes", service: "Car Moing", time: "9/9/2018 2:00")]))
        requestsData.append(allRequests(sectionTitle: "Accedent2",section : 1, collapsed :false, request: [request(name: "Taha", brand: "Mercedes", service: "Car Moing", time: "9/9/2018 2:00")]))
        requestsData.append(allRequests(sectionTitle: "Accedent2",section : 3, collapsed :false, request: [request(name: "Taha", brand: "Mercedes", service: "Car Moing", time: "9/9/2018 2:00")]))
//        requestsData?.append(allRequests)
    }
    @IBAction func btnSwitch(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            status = 0
        }else if sender.selectedSegmentIndex == 1{
            status = 1
        }else if sender.selectedSegmentIndex == 2{
            status = 2
        }
        tblRequests.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension RequestsVC : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestsData[section].collapsed ? 0 : requestsData[section].request.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "SearchForLocTableViewCell")
        if status == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell", for: indexPath) as! RequestCell
            let item: request = requestsData[indexPath.section].request[indexPath.row]
            cell.set(item)
            return cell
        }else if status == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestProgressCell", for: indexPath) as! RequestProgressCell
            let item: request = requestsData[indexPath.section].request[indexPath.row]
            cell.set(req: item)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestInvoiceCell", for: indexPath) as! RequestInvoiceCell
            let item: request = requestsData[indexPath.section].request[indexPath.row]
            cell.set(req: item)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView
        if section == 0 {
            header?.lblTitle?.text = "Accident"
        }else if section == 1  {
            header?.lblTitle?.text = "Service"
        }else{
            header?.lblTitle?.text = "Emergency"
        }
        //        header.arrowLabel.text = ">"
        header?.setCollapsed(collapsed: requestsData[section].collapsed)
        
        header?.section = section
        header?.delegate = self
        
        return header
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
}
extension RequestsVC : HeaderViewDelegate {
    func toggleSection(header: UITableViewHeaderFooterView, section: Int) {
        let header = header as! HeaderView
        let collapsed = !requestsData[section].collapsed
        header.setCollapsed(collapsed: collapsed)
        requestsData[section].collapsed = collapsed
        tblRequests.reloadSections(NSIndexSet(index: section) as IndexSet, with: .fade)
    }
}
struct allRequests {
    var sectionTitle :String
    var section : Int
    var collapsed :Bool
    var request :[request]
    init(sectionTitle :String,section: Int,collapsed:Bool,request:[request]) {
        self.sectionTitle = sectionTitle
        self.request = request
        self.collapsed = collapsed
        self.section = section
    }
}
struct request {
    var name :String
    var brand :String
    var service :String
    var time :String
    
    init(name :String,brand :String,service :String,time :String) {
        self.name = name
        self.brand = brand
        self.service = service
        self.time = time
    }
}
extension RequestsVC: HttpHelperDelegate {
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
                print( Result["result"]["pendingList"]["emergencyOrders"])
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
