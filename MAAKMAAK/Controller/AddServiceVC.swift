//
//  AddServiceVC.swift
//  MAAKMAAK
//
//  Created by apple on 3/3/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import UIKit
import DropDown
class AddServiceVC: UIViewController {

    var pushed = ""
    let serviceTypeDD = DropDown()
    let serviceDD = DropDown()
    var service : ServiceType?
    var price = 0
    var index = -1
    var sericeTypeList = [ServiceType]()
    var serviceList = [ServiceType]()
    var addServiceDelegate :AddingService?
    @IBOutlet weak var txtPrice: UITextField!
    
    @IBOutlet weak var btnServiceType: UIButton!
    @IBOutlet weak var btnService: UIButton!
    lazy var dropDowns: [DropDown] = {
        return [
            self.serviceTypeDD,
            self.serviceDD,
            ]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pushed)
        getServices()
        // Do any additional setup after loading the view.
    }
    func getServices() {
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        AddServiceModel.ServiceTypes(serviceid: -1) { (error:Error?, success:Bool, service:[ServiceType]?) in
            AppCommon.sharedInstance.dismissLoader(self.view)
            if success {
                self.sericeTypeList = service!
            }
        }
    }
    func getServiceForType(index:Int) {
        let serviceId = self.sericeTypeList[index].id
//        serviceList = [ServiceType]()
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        AddServiceModel.ServiceTypes(serviceid: serviceId!) { (error:Error?, success:Bool, service:[ServiceType]?) in
            AppCommon.sharedInstance.dismissLoader(self.view)
            if success {
                
                self.serviceList = service!
                let serviceType = self.serviceList.map {$0.nameEN}
                self.serviceDD.dataSource = serviceType as! [String]
                self.serviceDD.show()
            }
        }
    }
    @IBAction func btnShowDropDown(_ sender: UIButton) {
        if sender == btnServiceType {
            serviceTypeDD.anchorView = btnServiceType
            let serviceType = self.sericeTypeList.map {$0.nameEN}
            serviceTypeDD.bottomOffset = CGPoint(x: 0, y: btnServiceType.bounds.height + 5)
            serviceTypeDD.dataSource = serviceType as! [String]
            // Action triggered on selection
            serviceTypeDD.selectionAction = { [unowned self] (index, item) in
                self.btnServiceType.setTitle(item, for: .normal)
                self.index = index
            }
           serviceTypeDD.show()
        }else if sender == btnService{
            if index != -1 {
                
                self.getServiceForType(index: self.index)
                serviceDD.anchorView = btnService
                serviceDD.bottomOffset = CGPoint(x: 0, y: btnService.bounds.height + 5)
                // Action triggered on selection
                serviceDD.selectionAction = { [unowned self] (index, item) in
                    self.btnService.setTitle(item, for: .normal)
                }
//                serviceDD.show()
            }
            
            }
        
        
    }
    @IBAction func saveService(_ sender: Any) {
        self.price = Int(txtPrice.text ?? "") ?? 0
         if service != nil || price != 0 {
            addServiceDelegate?.addService(service: self.service!, price: self.price)
        }
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
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
protocol AddingService {
    func addService(service : ServiceType,price:Int)
}
