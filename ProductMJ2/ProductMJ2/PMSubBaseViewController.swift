//
//  PMSubBaseViewController.swift
//  ProductMJ2
//
//  Created by 刘Sir on 2020/9/25.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class PMSubBaseViewController: PMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    override func initSubviews() {
        super.initSubviews()
        let image = R.image.icon_e_bg()
        let bgView = UIImageView(image: image)
        bgView.frame = UIScreen.main.bounds
        bgView.contentMode = .scaleAspectFill
        view.addSubview(bgView)
        view.sendSubviewToBack(bgView)
    }
}
