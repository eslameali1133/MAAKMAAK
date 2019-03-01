//
//  Extension.swift
//  MAAKMAAK
//
//  Created by apple on 2/21/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import UIKit

class Extension: NSObject {

}

final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
