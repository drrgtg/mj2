//
//  PMSettingTableViewCell.swift
//  ProductMJ2
//
//  Created by 刘Sir on 2020/9/25.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class PMSettingTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
