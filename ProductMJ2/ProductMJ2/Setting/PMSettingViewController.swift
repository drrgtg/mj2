//
//  PMSettingViewController.swift
//  ProductMJ2
//
//  Created by 刘Sir on 2020/9/25.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit


class PMCellModel: NSObject {
    var name: String = ""
    var content: String = ""
    init(_ name: String, content: String) {
        super.init()
        self.name = name
        self.content = content
    }
}
class PMSettingViewController: PMSubBaseViewController {
    private var cacheSize = "\(arc4random()%10).0MB"

    @IBOutlet weak var settingLabel: UILabel!
    lazy var tableView: QMUITableView = {
        let tableView = QMUITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(R.nib.pmSettingTableViewCell)
        tableView.separatorStyle = .none
        return tableView
    }()

    var dataSource: [PMCellModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupDataSource()
    }
    override func initSubviews() {
        super.initSubviews()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(settingLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    func setupDataSource() {
        let cell1 = PMCellModel("Clear cache", content: cacheSize)
        let cell2 = PMCellModel("Version Information", content: PFCFBundleVersion())
        let cell3 = PMCellModel("Tems of use", content: "")
        let cell4 = PMCellModel("Privacy Policy", content: "")
        dataSource.append(contentsOf: [cell1,cell2,cell3,cell4])
        tableView.reloadData()
    }
}

extension PMSettingViewController: QMUITableViewDelegate, QMUITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        58
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PMSettingTableViewCellID", for: indexPath) as! PMSettingTableViewCell
        let item = dataSource[indexPath.row]
        cell.nameLabel.text = item.name
        cell.contentLabel.text = item.content
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            PMToast.showSuccess("clear successed")
            cacheSize = "0M"
            let item = dataSource[0]
            item.content = cacheSize
            tableView.reloadData()
        case 1:
            print("current version")
        case 2:
            let vc = PMTemsViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = PMPrivacyViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
