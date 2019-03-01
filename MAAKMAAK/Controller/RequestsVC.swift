//
//  RequestsVC.swift
//  MAAKMAAK
//
//  Created by M on 2/13/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import UIKit

class RequestsVC: UIViewController {

    var requestsData :[allRequests]?
    @IBOutlet weak var tblRequests: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getRequests()
        tblRequests.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        // Do any additional setup after loading the view.
    }
    func getRequests(){
//        requestsData?.append(allRequests(sectionTitle: "Accedent1",section: 0,collapsed :false, request: [request(name: "Taha", brand: "Mercedes", service: "Car Moing", time: "9/9/2018 2:00")]))
//        requestsData?.append(allRequests(sectionTitle: "Accedent2",section : 1,collapsed :false, request: [request(name: "Taha", brand: "Mercedes", service: "Car Moing", time: "9/9/2018 2:00")]))
//        requestsData?.append(allRequests(sectionTitle: "Accedent2",section : 3,collapsed :false, request: [request(name: "Taha", brand: "Mercedes", service: "Car Moing", time: "9/9/2018 2:00")]))
//        requestsData?.append(allRequests)
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
        return requestsData![section].collapsed ? 0 : requestsData![section].request.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "SearchForLocTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell", for: indexPath) as! RequestCell
        let item: request = requestsData![indexPath.section].request[indexPath.row]
        cell.set(item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView
        
        header?.lblTitle?.text = requestsData![section].sectionTitle
        //        header.arrowLabel.text = ">"
        header?.setCollapsed(collapsed: requestsData![section].collapsed)
        
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
        let collapsed = !requestsData![section].collapsed
        header.setCollapsed(collapsed: collapsed)
        requestsData![section].collapsed = collapsed
        tblRequests.reloadSections(NSIndexSet(index: section) as IndexSet, with: .fade)
    }
}
struct allRequests {
    var sectionTitle :String
    var section : Int
    var collapsed :Bool
    var request :[request]
    init(sectionTitle :String,request:[request],section: Int,collapsed:Bool) {
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
