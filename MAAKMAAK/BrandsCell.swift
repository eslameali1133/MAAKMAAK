//
//  BrandsCell.swift
//  MaakMaakAPP
//
//  Created by M on 2/10/19.
//  Copyright © 2019 maakmaak. All rights reserved.
//

import UIKit

class BrandsCell: UITableViewCell {

    
    @IBOutlet weak var lblTitle: UILabel!
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
