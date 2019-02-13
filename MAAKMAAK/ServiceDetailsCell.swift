//
//  ServiceDetailsCell.swift
//  MaakMaakAPP
//
//  Created by M on 2/11/19.
//  Copyright © 2019 maakmaak. All rights reserved.
//

import UIKit

class ServiceDetailsCell: UITableViewCell {

    @IBOutlet weak var txtFrom: UITextField!
    @IBOutlet weak var txtTo: UITextField!
    @IBOutlet weak var btnSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
