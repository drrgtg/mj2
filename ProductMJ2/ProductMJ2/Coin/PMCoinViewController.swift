//
//  PMCoinViewController.swift
//  ProductMJ2
//
//  Created by 刘Sir on 2020/9/25.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit
import IAPurchaseManager

class PMProductItem: NSObject {
    var price: String = ""
    var goldNumber: String = ""
    var iapID: String = ""
    var desc: String = ""
    init(_ price: String, goldNumber: String, iapID: String, desc: String) {
        super.init()
        self.price = price
        self.goldNumber = goldNumber
        self.iapID = iapID
        self.desc = desc
    }
}
class PMCoinViewController: PMSubBaseViewController {
    private var coinBtn: QMUIButton?

    private let dataSource: Array = [
        PMProductItem("$6.99", goldNumber: "1000", iapID: "com.diantus.ProductMJ2.buy258", desc: "X 1000"),
        PMProductItem("$11.99", goldNumber: "2000", iapID: "com.diantus.ProductMJ2.buy388", desc: "X 2000"),
        PMProductItem("$19.99", goldNumber: "3000", iapID: "com.diantus.ProductMJ2.buy518", desc: "X 3000"),
        PMProductItem("$29.99", goldNumber: "4000", iapID: "com.diantus.ProductMJ2.buy648", desc: "X 4000"),
        PMProductItem("$49.99", goldNumber: "5000", iapID: "com.diantus.ProductMJ2.buy848", desc: "X 5000"),
        PMProductItem("$99.99", goldNumber: "6000", iapID: "com.diantus.ProductMJ2.buy998", desc: "X 6000"),
        PMProductItem("$59.99", goldNumber: "7000", iapID: "com.diantus.ProductMJ2.buy1298", desc: "X 7000"),
        PMProductItem("$69.99", goldNumber: "8000", iapID: "com.diantus.ProductMJ2.buy1998", desc: "X 8000"),
        PMProductItem("$79.99", goldNumber: "9000", iapID: "com.diantus.ProductMJ2.buy3998", desc: "X 9000"),
        PMProductItem("$89.99", goldNumber: "10000", iapID: "com.diantus.ProductMJ2.buy4998", desc: "X 10000")
    ]
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = (ScreenWidth - 96 - 25) / 2
        let height = width * 141 / 122
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 25
        layout.minimumInteritemSpacing = 25
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(R.nib.pmCoinCollectionViewCellID)
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 48, bottom: 15, right: 48)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Coins"
    }
    override func initSubviews() {
        super.initSubviews()
        
        // rightBar
        let rightBtn = QMUIButton(type: .custom)
        rightBtn.setImage(R.image.icon_i_golds(), for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        rightBtn.setTitle("", for: .normal)
        rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        rightBtn.setTitleColor(.white, for: .normal)
        rightBtn.spacingBetweenImageAndTitle = 6
        rightBtn.sizeToFit()
        coinBtn = rightBtn
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let goldNumber = UserDefaults.standard.string(forKey: kIAPDefaultGoldNumber) {
            coinBtn?.setTitle(goldNumber, for: .normal)
            coinBtn?.sizeToFit()
        }
    }
    
    // Param MARK: private method
    private func payAtIndex(_ row: Int) {
        let product = dataSource[row]
        IAPManager.shared.purchaseProductWithId(productId: product.iapID) {[weak self] (error) -> Void in
            if error == nil, let sself = self {
              // successful purchase!
                if let goldNumber = UserDefaults.standard.string(forKey: kIAPDefaultGoldNumber) {
                    let total = Int(goldNumber)! + Int(product.goldNumber)!
                    UserDefaults.standard.setValue("\(total)", forKey: kIAPDefaultGoldNumber)
                    sself.coinBtn?.setTitle("\(total)", for: .normal)
                    sself.coinBtn?.sizeToFit()
                }
            } else {
              // something wrong..
                PMToast.showToast(error?.localizedDescription ?? "")
            }
        }
    }
}
extension PMCoinViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PMCoinCollectionViewCellID", for: indexPath) as! PMCoinCollectionViewCell
        let product = dataSource[indexPath.row]
        cell.numberLabel.text = product.desc
        cell.moneyBtn.setTitle(product.price, for: .normal)
        cell.clickHandler = {[weak self] in
            self?.payAtIndex(indexPath.row)
        }
        return cell
    }
}

