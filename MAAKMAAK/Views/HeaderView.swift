//
//  CategoryHeader.swift
//  Glamera
//
//  Created by apple on 2/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var arrowLabel: UILabel!
    @IBOutlet weak var vBackground: UIView!
     @IBOutlet weak var lblTitle: UILabel!
    var section: Int = 0
    weak var delegate: HeaderViewDelegate?
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    @objc private func didTapHeader() {
        delegate?.toggleSection(header: self, section: section)
    }
    
    func setCollapsed(collapsed: Bool){
        arrowLabel?.rotate(collapsed ? 0.0 : .pi)
    }
}
extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation, forKey: nil)
    }
}
protocol HeaderViewDelegate: class {
    func toggleSection(header: UITableViewHeaderFooterView, section: Int)
}
