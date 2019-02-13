//
//  ServiceDetailsCell.swift
//  MaakMaakAPP
//
//  Created by M on 2/11/19.
//  Copyright © 2019 maakmaak. All rights reserved.
//

import UIKit

class ServiceDetailsVC: UIViewController {

    var items = [ServiceDetails]()
    @IBOutlet weak var tblDetails: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        tblDetails.changeView()
        // Do any additional setup after loading the view.
    }
    func fillData() {
        items.append(ServiceDetails(from: "", to: "", isSelected: false, index: 0))
        items.append(ServiceDetails(from: "", to: "", isSelected: false, index: 1))
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
extension ServiceDetailsVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceDetailsCell", for: indexPath) as! ServiceDetailsCell
        cell.txtFrom.text = items[indexPath.row].from
        cell.txtFrom.text = items[indexPath.row].to
        cell.btnSwitch.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        cell.btnSwitch.tag = indexPath.row
        cell.btnSwitch.isOn = items[indexPath.row].isSelected
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        pushView(controller: <#T##UIViewController#>, storyboardName: <#T##String#>)
        performSegue(withIdentifier: "openService", sender: self)
    }
    @objc func switchValueDidChange(_ sender: UISwitch) {
        items[sender.tag].isSelected = sender.isOn ? true : false
        print(items[sender.tag].index,"-->",items[sender.tag].isSelected)
    }
    
}
struct ServiceDetails {
    var from:String
    var to:String
    var isSelected:Bool
    var index:Int
}
