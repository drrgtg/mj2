//
//  PMBaseNavigationController.swift
//  ProductMJ2
//
//  Created by 刘Sir on 2020/9/25.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class PMBaseNavigationController: QMUINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .clear

    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
}
