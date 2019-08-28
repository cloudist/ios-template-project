//
//  SampleViewController.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/21.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit
import RxViewController
import RxSwift
import RxDataSources

class SampleViewController: TableViewController {

    var viewModel: SampleViewModel
    
    init(viewModel: SampleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        tableView.mj_header.rx.refreshing
            .bind(to: viewModel.headerRefreshTrigger)
            .disposed(by: rx.disposeBag)
        tableView.mj_footer.rx.refreshing
            .bind(to: viewModel.footerRefreshTrigger)
            .disposed(by: rx.disposeBag)
        
        viewModel.headerLoading
            .drive(tableView.mj_header.rx.isRefreshing)
            .disposed(by: rx.disposeBag)
        viewModel.footerState
            .bind(to: tableView.mj_footer.rx.refreshFooterState)
            .disposed(by: rx.disposeBag)
        
        viewModel.tableData.bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { _, ele, cell in
            cell.textLabel?.text = ele
        }.disposed(by: rx.disposeBag)
    }
}
