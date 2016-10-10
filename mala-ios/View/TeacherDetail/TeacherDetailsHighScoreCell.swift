//
//  TeacherDetailsHighScoreCell.swift
//  mala-ios
//
//  Created by Elors on 1/5/16.
//  Copyright © 2016 Mala Online. All rights reserved.
//

import UIKit

class TeacherDetailsHighScoreCell: MalaBaseCell {

    // MARK: - Property
    var model: [HighScoreModel?] = [] {
        didSet {
            // 设置数据模型后，刷新TableView高度
            tableView.models = model
            tableView.snp.updateConstraints { (make) -> Void in
                make.height.equalTo(Int(MalaLayout_DeatilHighScoreTableViewCellHeight) * (model.count+1))
            }
        }
    }
    
    
    // MARK: - Components
    private lazy var tableView: TeacherDetailsHighScoreTableView = {
        let tableView = TeacherDetailsHighScoreTableView(frame: CGRect.zero, style: .plain)
        return tableView
    }()
    
    
    // MARK: - Constructed
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUserInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Method
    private func setupUserInterface() {
        // SubViews
        content.addSubview(tableView)
        
        // Autolayout
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.content.snp.top)
            make.left.equalTo(self.content.snp.left)
            make.bottom.equalTo(self.content.snp.bottom)
            make.right.equalTo(self.content.snp.right)
        }
    }
}
