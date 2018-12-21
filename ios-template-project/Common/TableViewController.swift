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
    
    let headerRefreshTrigger = PublishSubject<Void>()
    let footerRefreshTrigger = PublishSubject<Void>()
    
    let isHeaderLoading = BehaviorRelay(value: false)
    let footerLoadingStatus = BehaviorRelay<RxMJRefreshFooterState>(value: RxMJRefreshFooterState.default)
    
    lazy var tableView: TableView = {
        let tableView = TableView(frame: .zero, style: .plain)
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
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
        stackView.spacing = 0
        stackView.addArrangedSubview(tableView)
        
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_footer = MJRefreshAutoStateFooter()
    }
    
    override func updateUI() {
        super.updateUI()
    }
    
    override func bindViewModel() {
        tableView.mj_header.rx.refreshing.asObservable().bind(to: headerRefreshTrigger).disposed(by: rx.disposeBag)
        tableView.mj_footer.rx.refreshing.asObservable().bind(to: footerRefreshTrigger).disposed(by: rx.disposeBag)
        
        isHeaderLoading.asDriver().drive(tableView.mj_header.rx.isRefreshing).disposed(by: rx.disposeBag)
        footerLoadingStatus.asDriver().drive(tableView.mj_footer.rx.refreshFooterState).disposed(by: rx.disposeBag)
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
