//
//  ProfileItemCollectionViewCell.swift
//  mala-ios
//
//  Created by 王新宇 on 2016/11/18.
//  Copyright © 2016年 Mala Online. All rights reserved.
//

import UIKit

class ProfileItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    var model: ProfileElementModel? {
        didSet {
            iconView.image = UIImage(named: model?.iconName ?? "")
            newMessageView.image = UIImage(named: model?.newMessageIconName ?? "")
            titleLabel.text = model?.controllerTitle
            
            if let title = model?.controllerTitle {
                if title == L10n.myOrder {
                    newMessageView.isHidden = !(MalaUnpaidOrderCount > 0)
                }else if title == L10n.myComment {
                    newMessageView.isHidden = !(MalaToCommentCount > 0)
                }
            }
        }
    }
    
    
    // MARK: - Components
    /// 图标
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    /// 新消息标签
    private lazy var newMessageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        return imageView
    }()
    /// 标题标签
    private lazy var titleLabel: UILabel = {
        let label = UILabel(
            fontSize: 14,
            textColor: UIColor(named: .ArticleText)
        )
        return label
    }()
    
    
    // MARK: - Instance Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUserInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Method
    private func setupUserInterface() {
        // SubViews
        contentView.addSubview(iconView)
        contentView.addSubview(newMessageView)
        contentView.addSubview(titleLabel)
        
        // AutoLayout
        iconView.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(contentView)
            maker.top.equalTo(contentView).offset(13)
            maker.width.equalTo(53)
            maker.height.equalTo(53)
        }
        newMessageView.snp.makeConstraints { (maker) in
            maker.top.equalTo(iconView)
            maker.right.equalTo(contentView).offset(-10)
            maker.width.equalTo(39)
            maker.height.equalTo(15)
        }
        titleLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(contentView)
            maker.top.equalTo(iconView.snp.bottom).offset(17)
            maker.height.equalTo(14)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newMessageView.isHidden = true
    }
}
