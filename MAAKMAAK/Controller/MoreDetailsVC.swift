//
//  MoreDetailsVC.swift
//  MAAKMAAK
//
//  Created by apple on 2/24/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import UIKit

class MoreDetailsVC: UIViewController {

    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tblInvoice: ContentSizedTableView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblService: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableViewHeight.constant = self.tblInvoice.contentSize.height
        self.view.layoutIfNeeded()
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
extension MoreDetailsVC :UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceCell", for: indexPath) as! InvoiceCell
        return cell
    }
    
    
}
