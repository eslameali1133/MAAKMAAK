//
//  ServiceVC.swift
//  MaakMaakAPP
//
//  Created by M on 2/10/19.
//  Copyright © 2019 maakmaak. All rights reserved.
//

import UIKit

class ServiceVC: UIViewController {

    var items = [Services]()
    @IBOutlet weak var tblServices: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblServices.changeView()
        fillData()
        // Do any additional setup after loading the view.
    }
    func fillData(){
        items.append(Services(index: 0, serviceName: "repair"))
        items.append(Services(index: 1, serviceName: "Motors"))
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
extension ServiceVC :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
        cell.lblServiceName.text = items[indexPath.row].serviceName
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        pushView(controller: <#T##UIViewController#>, storyboardName: <#T##String#>)
        performSegue(withIdentifier: "openService", sender: self)
    }
    
    
}
struct Services {
    var index :Int
    var serviceName :String
}
