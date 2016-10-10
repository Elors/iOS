//
//  TeacherDetailsHeaderView.swift
//  mala-ios
//
//  Created by Elors on 1/7/16.
//  Copyright © 2016 Mala Online. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class TeacherDetailsHeaderView: UIView {

    // MARK: - Property
    var model: TeacherDetailModel = TeacherDetailModel() {
        didSet {
            /// 教师头像URL
            guard let url = URL(string: model.avatar ?? "") else {
                println("TeacherDetailsHeaderView - AvatarURL Format Error")
                return
            }
            avatarView.ma_setImage(url, placeholderImage: UIImage(named: "avatar_placeholder"))
            
            /// 教师姓名
            nameLabel.text = model.name
            nameLabel.sizeToFit()
            
            /// 教师性别
            if model.gender == "f" {
                genderIcon.image = UIImage(named: "gender_female")
            }else if model.gender == "m" {
                genderIcon.image = UIImage(named: "gender_male")
            }else {
                genderIcon.image = UIImage(named: "")
            }
            
            /// 教授学科
            subjectLabel.text = model.subject
            
            /// 价格
            priceLabel.text = String(MinPrice: model.min_price.money, MaxPrice: model.max_price.money)
            
            /// 教龄
            teachingAgeLabel.text = model.teachingAgeString
            teachingAgeProgressBar.progress = Double(model.teaching_age)/20
            
            /// 级别
            levelLabel.text = String(format: "T%d", model.level)
            levelProgressBar.progress = Double(model.level)/10
        }
    }
    
    
    // MARK: - Components
    /// 内部控件容器（注意本类继承于 UIView 而非 UITableViewCell）
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    /// 头像显示控件
    private lazy var avatarView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar_placeholder"))
        imageView.layer.cornerRadius = (MalaLayout_AvatarSize-5)*0.5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tag = 999
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TeacherDetailsHeaderView.avatarDidTap)))
        return imageView
    }()
    /// 头像背景
    private lazy var avatarBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = MalaLayout_AvatarSize*0.5
        view.layer.masksToBounds = true
        return view
    }()
    /// 会员图标显示控件
    private lazy var vipIconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "vip_icon"))
        imageView.layer.cornerRadius = MalaLayout_VipIconSize*0.5
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    /// 老师姓名label
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    /// 老师性别Icon
    private lazy var genderIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "gender_female"))
        return imageView
    }()
    /// 科目label
    private lazy var subjectLabel: UILabel = {
        let label = UILabel()
        label.textColor = MalaColor_939393_0
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    /// 价格label
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = MalaColor_939393_0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    /// 分割线
    private lazy var separatorLine: UIView = {
        let view = UIView.separator(MalaColor_E5E5E5_0)
        return view
    }()
    /// 教龄进度条
    private lazy var teachingAgeProgressBar: KYCircularProgress = {
        let progress = KYCircularProgress(frame: CGRect(x: 0, y: 0, width: 50, height: 50), showProgressGuide: true)
        progress.lineWidth = 2.5
        progress.guideLineWidth = 2.5
        progress.colors = [MalaColor_FA7A7A_0]
        progress.progressGuideColor = MalaColor_EEEEEE_0
        progress.startAngle = -M_PI_2
        progress.endAngle = -M_PI_2
        progress.progress = 0.35
        return progress
    }()
    /// 教龄图标
    private lazy var teachingAgeIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "teachingAge_icon"))
        return imageView
    }()
    /// 教龄文字标签
    private lazy var teachingAgeString: UILabel = {
        let label = UILabel(
            text: "教龄",
            fontSize: 14,
            textColor: MalaColor_828282_0
        )
        return label
    }()
    /// 教龄标签
    private lazy var teachingAgeLabel: UILabel = {
        let label = UILabel(
            text: "0年",
            fontSize: 14,
            textColor: MalaColor_828282_0
        )
        return label
    }()
    /// 级别进度条
    private lazy var levelProgressBar: KYCircularProgress = {
        let progress = KYCircularProgress(frame: CGRect(x: 0, y: 0, width: 50, height: 50), showProgressGuide: true)
        progress.lineWidth = 2.5
        progress.guideLineWidth = 2.5
        progress.colors = [MalaColor_FDDC55_0]
        progress.progressGuideColor = MalaColor_EEEEEE_0
        progress.startAngle = -M_PI_2
        progress.endAngle = -M_PI_2
        progress.progress = 0.35
        return progress
    }()
    /// 级别图标
    private lazy var levelIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "level_icon"))
        return imageView
    }()
    /// 级别文字标签
    private lazy var levelString: UILabel = {
        let label = UILabel(
            text: "级别",
            fontSize: 14,
            textColor: MalaColor_828282_0
        )
        return label
    }()
    /// 级别标签
    private lazy var levelLabel: UILabel = {
        let label = UILabel(
            text: "T1",
            fontSize: 14,
            textColor: MalaColor_828282_0
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
        // Style
        self.backgroundColor = UIColor.clear
        
        // SubViews
        addSubview(contentView)
        contentView.addSubview(avatarBackground)
        contentView.addSubview(avatarView)
        contentView.addSubview(vipIconView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(genderIcon)
        contentView.addSubview(subjectLabel)
        contentView.addSubview(priceLabel)
        
        contentView.addSubview(separatorLine)
        contentView.addSubview(teachingAgeProgressBar)
        contentView.addSubview(teachingAgeIcon)
        contentView.addSubview(teachingAgeString)
        contentView.addSubview(teachingAgeLabel)
        contentView.addSubview(levelProgressBar)
        contentView.addSubview(levelIcon)
        contentView.addSubview(levelString)
        contentView.addSubview(levelLabel)
        
        
        // Autolayout
        contentView.snp.makeConstraints({ (make) -> Void in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(MalaLayout_DetailHeaderContentHeight)
        })
        avatarBackground.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(12)
            make.bottom.equalTo(separatorLine.snp.top).offset(-7)
            make.width.equalTo(MalaLayout_AvatarSize)
            make.height.equalTo(MalaLayout_AvatarSize)
        }
        avatarView.snp.makeConstraints({ (make) -> Void in
            make.center.equalTo(avatarBackground.snp.center)
            make.size.equalTo(avatarBackground.snp.size).offset(-5)
        })
        vipIconView.snp.makeConstraints({ (make) -> Void in
            make.right.equalTo(avatarView.snp.right).offset(-3)
            make.bottom.equalTo(avatarView.snp.bottom).offset(-3)
            make.width.equalTo(MalaLayout_VipIconSize)
            make.height.equalTo(MalaLayout_VipIconSize)
        })
        nameLabel.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(contentView.snp.top).offset(12)
            make.left.equalTo(avatarView.snp.right).offset(12)
            make.height.equalTo(16)
        })
        genderIcon.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.left.equalTo(nameLabel.snp.right).offset(12)
            make.width.equalTo(13)
            make.height.equalTo(13)
        })
        subjectLabel.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(nameLabel.snp.left)
            make.width.equalTo(36)
            make.height.equalTo(12)
        })
        priceLabel.snp.makeConstraints({ (make) -> Void in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(subjectLabel.snp.right).offset(12)
            make.right.equalTo(contentView.snp.right).offset(-12)
            make.height.equalTo(12)
        })
        separatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(subjectLabel.snp.bottom).offset(10)
            make.height.equalTo(MalaScreenOnePixel)
            make.left.equalTo(contentView.snp.left).offset(12)
            make.right.equalTo(contentView.snp.right).offset(-12)
        }
        teachingAgeProgressBar.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLine.snp.bottom).offset(20)
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.right.equalTo(contentView.snp.right).multipliedBy(0.25)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        teachingAgeIcon.snp.makeConstraints { (make) in
            make.center.equalTo(teachingAgeProgressBar.snp.center)
            make.width.equalTo(23)
            make.height.equalTo(23)
        }
        teachingAgeString.snp.makeConstraints { (make) in
            make.width.equalTo(30)
            make.height.equalTo(14)
            make.left.equalTo(teachingAgeProgressBar.snp.right).offset(12)
            make.bottom.equalTo(teachingAgeProgressBar.snp.centerY).offset(-5)
        }
        teachingAgeLabel.snp.makeConstraints { (make) in
            make.width.equalTo(65)
            make.height.equalTo(14)
            make.left.equalTo(teachingAgeProgressBar.snp.right).offset(12)
            make.top.equalTo(teachingAgeProgressBar.snp.centerY).offset(5)
        }
        levelProgressBar.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLine.snp.bottom).offset(20)
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.right.equalTo(contentView.snp.right).multipliedBy(0.75)
        }
        levelIcon.snp.makeConstraints { (make) in
            make.center.equalTo(levelProgressBar.snp.center)
            make.width.equalTo(23)
            make.height.equalTo(23)
        }
        levelString.snp.makeConstraints { (make) in
            make.width.equalTo(30)
            make.height.equalTo(14)
            make.left.equalTo(levelProgressBar.snp.right).offset(12)
            make.bottom.equalTo(levelProgressBar.snp.centerY).offset(-5)
        }
        levelLabel.snp.makeConstraints { (make) in
            make.width.equalTo(65)
            make.height.equalTo(14)
            make.left.equalTo(levelProgressBar.snp.right).offset(12)
            make.top.equalTo(levelProgressBar.snp.centerY).offset(5)
        }
    }
    
    @objc private func avatarDidTap() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: MalaNotification_PushPhotoBrowser), object: avatarView)
    }
    
    deinit {
        println("TeacherDetailsHeaderView Deinit")
    }
}
