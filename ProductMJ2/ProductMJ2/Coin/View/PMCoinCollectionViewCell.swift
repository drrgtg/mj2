//
//  PMCoinCollectionViewCell.swift
//  ProductMJ2
//
//  Created by 刘Sir on 2020/9/25.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class PMCoinCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var moneyBtn: UIButton!
    var clickHandler: (()->(Void))?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func clickMoney(_ sender: Any) {
        clickHandler?()
    }
}
