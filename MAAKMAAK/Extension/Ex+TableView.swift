//
//  Ex+TableView.swift
//  MaakMaakAPP
//
//  Created by M on 2/10/19.
//  Copyright © 2019 maakmaak. All rights reserved.
//

import Foundation
import UIKit
extension UITableView{
    func changeView() {
        self.tableFooterView = UIView()
        self.separatorInset = .zero
        self.contentInset = .zero
    }
}
