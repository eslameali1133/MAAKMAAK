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
    var requests = [[AllRequests]] ()
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
    func getRequests() {
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        RequestsModel.getRequests(userId: "6f9be235-d4aa-4f29-a8d1-137b29bee612") { (error:Error?,success: Bool, message:String?,requests: [[AllRequests]]?) in
            AppCommon.sharedInstance.dismissLoader(self.view)
            if success{
                self.requests = requests!
                self.tblRequests.reloadData()
            }
        }
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
    @objc func acceptRequest(section:Int,row:Int){
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        let orderid = requests[status][section].services?[row].orderId
        RequestsModel.acceptRequest(orderId: orderid!) { (error:Error?, success:Bool, message:String?) in
            AppCommon.sharedInstance.dismissLoader(self.view)
            if success {
                self.getRequests()
                self.tblRequests.reloadData()
            }
        }
    }
    @objc func reject(section:Int,row:Int){
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        let orderid = requests[status][section].services?[row].orderId
        RequestsModel.rejectRequest(orderId: orderid!) { (error:Error?, success:Bool, message:String?) in
            AppCommon.sharedInstance.dismissLoader(self.view)
            if success {
                self.getRequests()
                self.tblRequests.reloadData()
            }
        }
    }
    
    @objc func showMoreInProgress(section: Int, row: Int){
        let storyBoard = UIStoryboard(name: "HomeVender", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RequestInProgressDetailsVC") as! RequestInProgressDetailsVC
        vc.serviceType = section // indicate the order type
        let orderId = requests[status][section].services?[row].orderId
        vc.OrderId = orderId
        self.navigationController?.pushViewController(vc, animated:true)
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
        return requests.count == 0 ? 0 : requests[status][section].services?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "SearchForLocTableViewCell")
        if status == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell", for: indexPath) as! RequestCell
//            let item: request = requestsData[indexPath.section].request[indexPath.row]
            let item: RequestServices = (requests[status][indexPath.section].services?[indexPath.row])!
            cell.btnShow.tag = indexPath.row
//            cell.btnAccept.addTarget(self, action: #selector(self.showMore(_:)), for: .touchUpInside)
            cell.selectTapped = { [unowned self] (selectedCell) -> Void in
                self.acceptRequest(section: indexPath.section, row: indexPath.row)
            }
            cell.rejectTapped = { [unowned self] (selectedCell) -> Void in
                self.reject(section: indexPath.section, row: indexPath.row)
            }
            cell.set(req: item)
            return cell
        }else if status == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestProgressCell", for: indexPath) as! RequestProgressCell
//            let item: request = requestsData[indexPath.section].request[indexPath.row]
            let item: RequestServices = (requests[status][indexPath.section].services?[indexPath.row])!
            cell.btnShowMore.tag = indexPath.section
            cell.showMore = { [unowned self] (selectedCell) -> Void in
                self.showMoreInProgress(section: indexPath.section, row: indexPath.row)
            }
            cell.set(req: item)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestInvoiceCell", for: indexPath) as! RequestInvoiceCell
//            let item: request = requestsData[indexPath.section].request[indexPath.row]
            let item: RequestServices = (requests[status][indexPath.section].services?[indexPath.row])!
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
        header?.arrowLabel.text = requests.count == 0 ? "" : "\(requests[status][section].services?.count ?? 0)"
        //        header.arrowLabel.text = ">"
//        header?.setCollapsed(collapsed: requestsData[section].collapsed)
        
        header?.section = section
        header?.delegate = self
        
        return header
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
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
