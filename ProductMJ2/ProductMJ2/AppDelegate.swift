//
//  AppDelegate.swift
//  ProductMJ2
//
//  Created by 刘Sir on 2020/9/24.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
            setupDefaultData()
            setupRootVC()
            return true
        }
        func setupRootVC(){
            let image = R.image.icon_common_BG()
            let bgView = UIImageView(image: image)
            bgView.frame = UIScreen.main.bounds
            bgView.contentMode = .scaleAspectFill
            let wind = UIWindow(frame: UIScreen.main.bounds)
            wind.addSubview(bgView)
            wind.sendSubviewToBack(bgView)
            let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "PMHomeViewControllerID")
            window = wind
            wind.rootViewController = PMBaseNavigationController(rootViewController: vc)
            wind.makeKeyAndVisible()
        }
        func setupDefaultData() {
            if UserDefaults.standard.string(forKey: kIAPDefaultGoldNumber) == nil {
                UserDefaults.standard.setValue("3000", forKey: kIAPDefaultGoldNumber)
            }
        }
}

