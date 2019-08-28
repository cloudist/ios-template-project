//
//  TableView.swift
//  ios-template-project
//
//  Created by 刘波 on 2018/12/20.
//  Copyright © 2018 cloudist. All rights reserved.
//

import UIKit

class TableView: UITableView {
    init() {
        super.init(frame: .zero, style: .grouped)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 50
        sectionHeaderHeight = 40
        backgroundColor = .clear
        cellLayoutMarginsFollowReadableWidth = false
        keyboardDismissMode = .onDrag
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableFooterView = UIView()
        tableFooterView = UIView()
    }
}
