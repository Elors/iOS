//
//  LearningReportTitlePageCell.swift
//  mala-ios
//
//  Created by 王新宇 on 16/5/19.
//  Copyright © 2016年 Mala Online. All rights reserved.
//

import UIKit

class LearningReportTitlePageCell: MalaBaseCardCell {
    
    // MARK: - Property
    override var asSample: Bool {
        didSet {
            if asSample {
                setupSampleData()
            }else {
                setupRealData()
            }
        }
    }
    
    // MARK: - Components
    /// 标题标签
    private lazy var titleLabel: UILabel = {
        let label = UILabel(
            text: "",
            fontSize: 16,
            textColor: UIColor(named: .ChartLabel)
        )
        return label
    }()
    /// 标题背景图
    private lazy var titleBackground: UIImageView = {
        let imageView = UIImageView(imageName: "reportTitle_background")
        return imageView
    }()
    /// 日期范围标签
    private lazy var dateLabel: UILabel = {
        let label = UILabel(
            text: "",
            fontSize: 10,
            textColor: UIColor.white
        )
        label.backgroundColor = UIColor(named: .ChartDateText)
        label.textAlignment = .center
        return label
    }()
    /// 文件夹图片
    private lazy var folderImage: UIImageView = {
        let imageView = UIImageView(imageName: "folder_icon")
        return imageView
    }()
    /// "学生姓名"文字
    private lazy var nameString: UILabel = {
        let label = UILabel(
            text: "学生姓名：",
            fontSize: 12,
            textColor: UIColor(named: .OptionSelectColor)
        )
        return label
    }()
    /// 学生姓名标签
    private lazy var nameLabel: UILabel = {
        let label = UILabel(
            text: "",
            fontSize: 12,
            textColor: UIColor(named: .HeaderTitle)
        )
        return label
    }()
    /// 姓名分割线
    private lazy var nameSeparator: UIImageView = {
        let imageView = UIImageView(imageName: "label_rightSeparator")
        return imageView
    }()
    /// "所在年纪"文字
    private lazy var gradeString: UILabel = {
        let label = UILabel(
            text: "所在年级：",
            fontSize: 12,
            textColor: UIColor(named: .OptionSelectColor)
        )
        return label
    }()
    /// 所在年级标签
    private lazy var gradeLabel: UILabel = {
        let label = UILabel(
            text: "",
            fontSize: 12,
            textColor: UIColor(named: .HeaderTitle)
        )
        return label
    }()
    /// 年级分割线
    private lazy var gradeSeparator: UIImageView = {
        let imageView = UIImageView(imageName: "label_leftSeparator")
        return imageView
    }()
    
    
    // MARK: - Instance Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUserInterface()
        setupSampleData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Method
    private func setupUserInterface() {
        // Style
        contentView.backgroundColor = UIColor(named: .CardBackground)
        
        // SubViews
        layoutView.addSubview(titleLabel)
        layoutView.addSubview(titleBackground)
        layoutView.addSubview(dateLabel)
        layoutView.addSubview(folderImage)
        layoutView.addSubview(nameString)
        layoutView.addSubview(nameLabel)
        layoutView.addSubview(nameSeparator)
        layoutView.addSubview(gradeString)
        layoutView.addSubview(gradeLabel)
        layoutView.addSubview(gradeSeparator)
        
        // Autolayout
        titleBackground.snp.makeConstraints { (maker) in
            maker.center.equalTo(titleLabel)
            maker.width.equalTo(titleLabel).offset(16)
        }
        titleLabel.snp.makeConstraints { (maker) in
            maker.height.equalTo(20)
            maker.centerX.equalTo(layoutView)
            maker.top.equalTo(layoutView.snp.bottom).multipliedBy(0.09)
        }
        dateLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(160)
            maker.height.equalTo(24)
            maker.centerX.equalTo(layoutView)
            maker.top.equalTo(layoutView.snp.bottom).multipliedBy(0.18)
        }
        folderImage.snp.makeConstraints { (maker) in
            maker.top.equalTo(layoutView.snp.bottom).multipliedBy(0.32)
            maker.centerX.equalTo(layoutView)
            maker.width.equalTo(100.5)
            maker.height.equalTo(142.5)
        }
        nameString.snp.makeConstraints { (maker) in
            maker.top.equalTo(layoutView.snp.bottom).multipliedBy(0.73)
            maker.height.equalTo(12)
            maker.right.equalTo(layoutView.snp.centerX)
        }
        nameLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(nameString)
            maker.left.equalTo(layoutView.snp.centerX)
        }
        nameSeparator.snp.makeConstraints { (maker) in
            maker.top.equalTo(layoutView.snp.bottom).multipliedBy(0.76)
            maker.height.equalTo(6)
            maker.left.equalTo(layoutView)
            maker.right.equalTo(nameLabel).offset(20)
        }
        gradeString.snp.makeConstraints { (maker) in
            maker.top.equalTo(layoutView.snp.bottom).multipliedBy(0.81)
            maker.height.equalTo(12)
            maker.right.equalTo(layoutView.snp.centerX)
        }
        gradeLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(gradeString)
            maker.left.equalTo(layoutView.snp.centerX)
        }
        gradeSeparator.snp.makeConstraints { (maker) in
            maker.top.equalTo(layoutView.snp.bottom).multipliedBy(0.84)
            maker.height.equalTo(6)
            maker.left.equalTo(gradeString).offset(-20)
            maker.right.equalTo(layoutView)
        }
    }
    
    // 设置样本数据
    private func setupSampleData() {
        titleLabel.text = "麻辣老师学生学习报告样本"
        dateLabel.text = "2016年4月17～2016年6月13"
        nameLabel.text = "王琦"
        gradeLabel.text = "初中二年级"
    }
    
    private func setupRealData() {
        titleLabel.text = "麻辣老师学生学习报告"
        dateLabel.text = MalaSubjectReport.timePeriod
        nameLabel.text = MalaUserDefaults.studentName.value ?? ""
        gradeLabel.text = MalaConfig.malaGradeName()[MalaSubjectReport.grade_id]
    }
}
