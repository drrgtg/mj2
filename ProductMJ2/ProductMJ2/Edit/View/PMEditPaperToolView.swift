//
//  PMEditPaperToolView.swift
//  ProductMJ2
//
//  Created by 刘Sir on 2020/9/25.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class PMEditPaperToolView: UIView {
    
    
    var scrollView1: UIScrollView?
    var scrollView2: UIScrollView?
    var clickBGColorBlock: ((UIImage?) -> (Void))?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        // scroll1
        let scroll1 = UIScrollView(frame: .zero)
        self.addSubview(scroll1)
        scroll1.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        scroll1.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.height.equalTo(45)
        }
        scrollView1 = scroll1
        // scroll2
        let scroll2 = UIScrollView(frame: .zero)
        self.addSubview(scroll2)
        scroll2.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        scroll2.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(scroll1.snp.bottom).offset(36)
            make.height.equalTo(76)
        }
        scrollView2 = scroll2
        fillSubViews()
    }
    
    // fillSubViews
    func fillSubViews() {
        let model = PMStickerModel()
        for i in 0..<model.popularSticker1.count {
            let image = model.popularSticker1[i]
            let x = i * 55
            let tempView = PMPickerItemView(frame: CGRect(x: x, y: 0, width: 45, height: 45))
            scrollView1?.addSubview(tempView)
            tempView.tag = 100 + i
            tempView.contentBtn.setImage(image, for: .normal)
            tempView.clickBlock = {[weak self] (tag) in
                guard let sself = self else {
                    return
                }
                sself.clickSmContentBtn(tag, count: model.popularSticker1.count)
                sself.clickBGColorBlock?(image)
            }
        }
        scrollView1?.contentSize = CGSize(width: model.popularSticker1.count * 55, height: 45)
        // backgroundColor
        for i in 0..<model.allSticker2.count {
            let image = model.allSticker2[i]
            let x = i * 84
            let tempView = PMPickerItemView(frame: CGRect(x: x, y: 0, width: 76, height: 76))
            tempView.tag = 200 + i
            scrollView2?.addSubview(tempView)
            tempView.contentBtn.setImage(image, for: .normal)
            tempView.clickBlock = {[weak self] (tag) in
                guard let sself = self else {
                    return
                }
                sself.clickBGContentBtn(tag, count: model.allSticker2.count)
                sself.clickBGColorBlock?(image)
            }
        }
        scrollView2?.contentSize = CGSize(width: model.allSticker2.count * 84, height: 76)
    }
    func clickSmContentBtn(_ tag: Int, count: Int) {
        for i in 0..<count {
            let btn = scrollView1?.viewWithTag(100 + i) as! PMPickerItemView
            if tag == 100 + i {
                btn.isSelect = true
            } else {
                btn.isSelect = false
            }
        }
    }
    func clickBGContentBtn(_ tag: Int, count: Int) {
        for i in 0..<count{
            let btn = scrollView2?.viewWithTag(200 + i) as! PMPickerItemView
            if tag == 200 + i {
                btn.isSelect = true
            } else {
                btn.isSelect = false
            }
        }
    }
}
