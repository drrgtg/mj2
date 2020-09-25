//
//  PMEditBorderToolView.swift
//  ProductMJ2
//
//  Created by 刘Sir on 2020/9/25.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class PMEditBorderToolView: UIView {

    @IBOutlet weak var borderSlider: QMUISlider!
    @IBOutlet weak var colorBg: UIImageView!
    @IBOutlet weak var colorSlider: UISlider!
    lazy var numberBtn: QMUIButton = {
        let btn = QMUIButton(type: .custom)
        btn.setBackgroundImage(R.image.icon_e_slider_level(), for: .normal)
        btn.setTitle("0", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 10)
        btn.sizeToFit()
        return btn
    }()
    var clickBorderHandler: ((CGFloat)->(Void))?
    var clickColorHandler: ((UIColor?)->(Void))?

    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(numberBtn)
        borderSlider.setThumbImage(R.image.icon_e_slider(), for: .normal)
        colorSlider.setThumbImage(R.image.icon_e_color_slider(), for: .normal)
        numberBtn.snp.makeConstraints { (make) in
            make.leading.equalTo(borderSlider)
            make.bottom.equalTo(borderSlider.snp.top)
            make.width.equalTo(14)
            make.height.equalTo(17)
        }
        borderSlider.value = 0
        colorSlider.value = 0
    }
    // max 20
    @IBAction func borderValueChanged(_ sender: Any) {
        let width = borderSlider.qmui_width - R.image.icon_e_slider()!.size.width
        let step = width * CGFloat(borderSlider.value)
        numberBtn.snp.remakeConstraints { (make) in
            make.leading.equalTo(borderSlider.snp.leading).offset(step)
            make.bottom.equalTo(borderSlider.snp.top)
            make.width.equalTo(14)
            make.height.equalTo(17)
        }
        let number = roundf(Float(20 * borderSlider.value))
        numberBtn.setTitle("\(Int(number))", for: .normal)
        numberBtn.sizeToFit()
        clickBorderHandler?(CGFloat(number))
    }
    @IBAction func colorValueChanged(_ sender: Any) {
        let x = colorSlider.qmui_width * CGFloat(colorSlider.value)
        let color = colorBg.pickColor(at: CGPoint(x: x, y: colorSlider.qmui_height/2))
        clickColorHandler?(color)
    }
}
