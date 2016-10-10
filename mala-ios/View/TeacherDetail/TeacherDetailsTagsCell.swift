//
//  TeacherDetailsTagsCell.swift
//  mala-ios
//
//  Created by Elors on 1/5/16.
//  Copyright © 2016 Mala Online. All rights reserved.
//

import UIKit

class TeacherDetailsTagsCell: MalaBaseCell {

    // MARK: - Property
    /// 标签字符串数组
    var labels: [String] = [] {
        didSet {
            tagsView.labels = labels
        }
    }
    
    
    // MARK: - Components
    /// 标签容器
    lazy var tagsView: ThemeTagListView = {
        let tagsView = ThemeTagListView()
        tagsView.imageName = "tags_icon"
        tagsView.labelBackgroundColor = MalaColor_BCD0DE_0
        tagsView.textColor = MalaColor_5789AC_0
        return tagsView
    }()
    
    
    // MARK: - Instance Method
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
        content.addSubview(tagsView)
        
        // AutoLayout
        tagsView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(content.snp.top)
            make.left.equalTo(content.snp.left)
            make.bottom.equalTo(content.snp.bottom)
            make.height.equalTo(25)
            make.right.equalTo(content.snp.right)
        }
    }
}
