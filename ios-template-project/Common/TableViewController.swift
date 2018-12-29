//
//  TableViewController.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/20.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxMJ
import MJRefresh

class TableViewController: ViewController {
    
    lazy var tableView: TableView = {
        let tableView = TableView(frame: .zero, style: .plain)
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    var clearSelectionOnViewWillAppear = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearSelectionOnViewWillAppear ? deselectSelectedRow() : ()
    }
    
    override func makeUI() {
        super.makeUI()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_footer = MJRefreshAutoStateFooter()
    }
    
    override func updateUI() {
        super.updateUI()
    }
    
    override func bindViewModel() {
    }
}

extension TableViewController {
    func deselectSelectedRow() {
        guard let selectedIndexPaths = tableView.indexPathsForSelectedRows else { return }
        selectedIndexPaths.forEach { (indexpath) in
            tableView.deselectRow(at: indexpath, animated: false)
        }
    }
}

extension TableViewController: UITableViewDelegate {
    
}
