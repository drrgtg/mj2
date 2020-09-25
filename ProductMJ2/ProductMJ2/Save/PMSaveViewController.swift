//
//  PMSaveViewController.swift
//  ProductMJ2
//
//  Created by 刘Sir on 2020/9/25.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class PMSaveViewController: PMSubBaseViewController {

    var image: UIImage?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var againBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = image
        againBtn.layer.cornerRadius = againBtn.qmui_height/2
        againBtn.layer.masksToBounds = true
    }
    
    override func initSubviews() {
        super.initSubviews()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.icon_s_home(), style: .plain, target: self, action: #selector(goHome))
    }
    @objc func goHome() {
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func clickAgain(_ sender: Any) {
            goHome()
    }
}
