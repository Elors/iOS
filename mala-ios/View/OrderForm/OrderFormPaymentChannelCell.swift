//
//  OrderFormPaymentChannelCell.swift
//  mala-ios
//
//  Created by 王新宇 on 16/5/13.
//  Copyright © 2016年 Mala Online. All rights reserved.
//

import UIKit

class OrderFormPaymentChannelCell: UITableViewCell {

    // MARK: - Property
    /// 支付方式
    var channel: MalaPaymentChannel = .Other {
        didSet {
            switch channel {
            case .Alipay:
                payChannelLabel.text = "支付宝"
                break
            case .Wechat:
                payChannelLabel.text = "微信"
                break
            case .Other:
                payChannelLabel.text = "其他支付方式"
                break
            }
        }
    }
    
    
    // MARK: - Components
    /// cell标题
    private lazy var titleLabel: UILabel = {
        let label = UILabel(
            text: "支付方式",
            fontSize: 15,
            textColor: MalaColor_333333_0
        )
        return label
    }()
    /// 支付方式
    private lazy var payChannelLabel: UILabel = {
        let label = UILabel(
            text: "其他支付方式",
            fontSize: 13,
            textColor: MalaColor_6C6C6C_0
        )
        return label
    }()
    
    
    // MARK: - Contructed
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(payChannelLabel)
        
        // Autolayout
        titleLabel.snp.updateConstraints { (maker) -> Void in
            maker.top.equalTo(self.contentView.snp.top).offset(16)
            maker.left.equalTo(self.contentView.snp.left).offset(12)
            maker.height.equalTo(15)
            maker.bottom.equalTo(self.contentView.snp.bottom).offset(-16)
        }
        payChannelLabel.snp.updateConstraints { (maker) -> Void in
            maker.centerY.equalTo(titleLabel.snp.centerY)
            maker.right.equalTo(self.contentView.snp.right).offset(-12)
            maker.height.equalTo(13)
        }
    }
}
