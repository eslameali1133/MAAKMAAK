//
//  moreVC.swift
//  MaakMaakAPP
//
//  Created by apple on 2/9/19.
//  Copyright © 2019 maakmaak. All rights reserved.
//

import UIKit

class moreVC: MYViewController {
    
    var items = [String]()
    @IBOutlet weak var tblMoe: UITableView!
    //    @IBOutlet weak var lblItemName: UILabel!
    var register :String = AppCommon.sharedInstance.localization("register")
    var logIn :String = AppCommon.sharedInstance.localization("Log_In")
    var brands = AppCommon.sharedInstance.localization("brands")
    var services = AppCommon.sharedInstance.localization("services")
    var request = AppCommon.sharedInstance.localization("requests")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        tblMoe.changeView()
        
//          tblMoe.reloadData()
        
        
        // Do any additional setup after loading the view.
    }
    func getData()  {
        items = [register,logIn,brands,services,"Requests"]
//          tblMoe.reloadData()
    }
    
    
//    @IBAction func MoveBtnCell(_ sender: UIImage) {
//        let point = sender.convert(CGPoint.zero, to: tableView)
//        let index = tableView.indexPathForRow(at: point)?.section
//        
//        
//    }
    
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
            
        default:
            break
        }
        
    }
    
}
