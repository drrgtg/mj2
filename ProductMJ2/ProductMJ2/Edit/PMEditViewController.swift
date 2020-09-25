//
//  PMEditViewController.swift
//  ProductMJ2
//
//  Created by 刘Sir on 2020/9/25.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class PMEditViewController: PMSubBaseViewController {

    var image: UIImage? = nil
    let contentImageView = UIImageView()
    var simage: UIImage?

    var borderWidth: CGFloat = 0
    var borderColor: UIColor = UIColor.white
    @IBOutlet weak var titleBtn: UIButton!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var bottomBGView: UIView!
    @IBOutlet weak var doneBtn: UIButton!
    var borderView: PMEditBorderToolView?
    var paperView: PMEditPaperToolView?
    var selectSticker: StickerView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView1Mode()
        setupView2Mode()
    }
    override func initSubviews() {
        super.initSubviews()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.icon_e_download(), style: .plain, target: self, action: #selector(clickRight))
        
        imageContainerView.addSubview(contentImageView)
        contentImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(30)
        }
        contentImageView.contentMode = .scaleAspectFill
        contentImageView.layer.cornerRadius = imageContainerView.qmui_width/2 - 30
        contentImageView.layer.masksToBounds = true
        contentImageView.layer.borderWidth = borderWidth
        contentImageView.layer.borderColor = borderColor.cgColor
        contentImageView.image = image
        
        let view1 = R.nib.pmEditBorderToolView(owner: nil)!
        bottomContainerView.addSubview(view1)
        view1.snp.makeConstraints { (make) in
            make.top.equalTo(doneBtn.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        borderView = view1
        view1.isHidden = false
        view1.backgroundColor = .clear
        
        let view2 = PMEditPaperToolView(frame: bottomContainerView.bounds)
        bottomContainerView.addSubview(view2)
        view2.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        paperView = view2
        view2.isHidden = true
        view2.backgroundColor = .clear
        
    }
    func setupView1Mode() {
        borderView?.clickBorderHandler = {[weak self] (width) in
            guard let sself = self else {
                return
            }
            sself.borderWidth = width
            sself.contentImageView.layer.borderWidth = sself.borderWidth
        }
        borderView?.clickColorHandler = {[weak self] (color) in
            guard let sself = self, let c = color else {
                return
            }
            sself.borderColor = c
            sself.contentImageView.layer.borderColor = sself.borderColor.cgColor
        }
    }
    func setupView2Mode() {
        paperView?.clickBGColorBlock = {[weak self] (image) in
            guard let sself = self, let i = image else {
                return
            }
            sself.addStickerView(i)

        }
    }
    func addStickerView(_ image: UIImage) {
        let stickerView = StickerView(contentFrame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height), contentImage: image)
        stickerView?.enabledControl = false
        stickerView?.enabledBorder = false
        stickerView?.delegate = self as StickerViewDelegate
        stickerView?.performTapOperation()
        imageContainerView.addSubview(stickerView!)
        stickerView?.center = imageContainerView.center
        selectSticker = stickerView
    }
    @IBAction func clickTitleBtn(_ sender: Any) {
        titleBtn.isSelected = !titleBtn.isSelected
        borderView?.isHidden = titleBtn.isSelected
        paperView?.isHidden = !titleBtn.isSelected
        doneBtn.isHidden = titleBtn.isSelected
    }
    @IBAction func clickDone(_ sender: Any) {
        // Do nothing
    }
    @objc func clickRight() {
        
        // use coin to save
        let alert = QMUIAlertController(title: "Save Image", message: "Speed 3000 gold coins to save image", preferredStyle: .alert)
        alert.addAction(QMUIAlertAction(title: "determine", style: .default, handler: { (_, _) in
            print("determine")
            self.payAndSave()
        }))
        alert.addCancelAction()
        alert.showWith(animated: true)
    }
    func payAndSave() {
        if let goldNumber = UserDefaults.standard.string(forKey: kIAPDefaultGoldNumber) {
            if Int(goldNumber) ?? 0 < 3000 {
                let vc = PMCoinViewController()
                navigationController?.pushViewController(vc, animated: true)
            } else {
                PMToast.showLoading("Saving")
                UserDefaults.standard.setValue("\(Int(goldNumber)! - 3000)", forKey: kIAPDefaultGoldNumber)
                simage = saveImage()
                if let saveImage = simage {
                    UIImageWriteToSavedPhotosAlbum(saveImage, self, #selector(imageSaveFinished(image:error:context:)), nil)
                }
            }
        }
    }
    @objc func imageSaveFinished(image: UIImage, error: Error, context: UnsafeRawPointer) {
        PMToast.hidLoading()
        let vc = PMSaveViewController()
        vc.image = simage
        navigationController?.pushViewController(vc, animated: true)
    }
    func saveImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(imageContainerView.frame.size,false, 0.0);
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        imageContainerView.layer.render(in: context)
        let snapShotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapShotImage
    }
    
}
extension PMEditViewController: StickerViewDelegate {

    func stickerViewDidTapContentView(_ stickerView: StickerView!) {
        if let sticker = selectSticker {
            sticker.enabledControl = false
            sticker.enabledBorder = false
        } else {
            selectSticker = stickerView
            selectSticker?.enabledBorder = true
            selectSticker?.enabledControl = true
        }
    }
    func stickerViewDidTapDeleteControl(_ stickerView: StickerView!) {
        for subView in imageContainerView.subviews {
            if let sv = subView as? StickerView {
                sv.performTapOperation()
                break
            }
        }
    }
}
