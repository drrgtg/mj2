//
//  PMHomeViewController.swift
//  ProductMJ2
//
//  Created by 刘Sir on 2020/9/25.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit
import SnapKit
import TZImagePickerController

class PMHomeViewController: PMBaseViewController {

    @IBOutlet weak var textImage: UIImageView!
    @IBOutlet weak var chooseBth: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    private let items: [UIImage?] = [R.image.icon_h_1(),R.image.icon_h_2(),R.image.icon_h_3(),R.image.icon_h_4(),R.image.icon_h_5()]
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(R.nib.pmHomeCollectionViewCell)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func initSubviews() {
        super.initSubviews()
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.icon_h_more(), style: .plain, target: self, action: #selector(clickRight))
        chooseBth.layer.cornerRadius = chooseBth.qmui_height/2
        chooseBth.layer.masksToBounds = true
    }
    @objc func clickRight() {
        // more
        let vc = PMSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func clickStore(_ sender: Any) {
        let vc = PMCoinViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func clickChoose(_ sender: Any) {
        guard let imagePickerVC = TZImagePickerController(maxImagesCount: 1, delegate: self) else {
            return
        }
        imagePickerVC.didFinishPickingPhotosHandle = {[weak self] (photos, assets, isSelectOriginalPhoto) in
            // go to edit
            guard let image = photos?.first else {
                return
            }
            let vc = PMEditViewController()
            vc.image = image
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        imagePickerVC.modalPresentationStyle = .overCurrentContext
        imagePickerVC.modalTransitionStyle = .crossDissolve
        present(imagePickerVC, animated: true, completion: nil)

    }

}

extension PMHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PMHomeCollectionViewCellID", for: indexPath) as! PMHomeCollectionViewCell
        cell.imageView.image = items[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.qmui_height - 30
        let width = height / 347 * 222
        return CGSize(width: width, height: height)
    }
}
extension PMHomeViewController: TZImagePickerControllerDelegate {
    
}
