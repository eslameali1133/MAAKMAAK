//
//  BrandsVC.swift
//  MaakMaakAPP
//
//  Created by M on 2/10/19.
//  Copyright © 2019 maakmaak. All rights reserved.
//

import UIKit

class BrandsVC: UIViewController {

    var items = [Brands]()
    @IBOutlet weak var tblBrands: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblBrands.changeView()
        fillData()

        // Do any additional setup after loading the view.
    }
    func fillData()  {
        items.append(Brands(index: 0, brand: "Mercedes", isSelected: false))
        items.append(Brands(index: 1, brand: "Toyota", isSelected: false))
        items.append(Brands(index: 2, brand: "Mitsubishi", isSelected: false))
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
extension BrandsVC :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrandsCell", for: indexPath) as! BrandsCell
        cell.lblTitle.text = items[indexPath.row].brand
        cell.btnSwitch.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        cell.btnSwitch.tag = indexPath.row
        cell.btnSwitch.isOn = items[indexPath.row].isSelected
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    @objc func switchValueDidChange(_ sender: UISwitch) {
        items[sender.tag].isSelected = sender.isOn ? true : false
        print(items[sender.tag].index,"-->",items[sender.tag].isSelected)
    }
    
}
struct Brands {
    var index:Int
    var brand :String
    var isSelected:Bool
}
