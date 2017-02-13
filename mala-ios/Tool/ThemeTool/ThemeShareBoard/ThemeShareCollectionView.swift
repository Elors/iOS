//
//  ThemeShareCollectionView.swift
//  mala-ios
//
//  Created by 王新宇 on 16/8/23.
//  Copyright © 2016年 Mala Online. All rights reserved.
//

import UIKit

private let ThemeShareCollectionViewCellReuseId = "ThemeShareCollectionViewCellReuseId"
private let ThemeShareCollectionViewSectionHeaderReuseId = "ThemeShareCollectionViewSectionHeaderReuseId"
private let ThemeShareCollectionViewSectionFooterReuseId = "ThemeShareCollectionViewSectionFooterReuseId"

class ThemeShareCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Property
    /// 会员专享服务数据
    var model: [IntroductionModel] = MalaConfig.shareItems() {
        didSet {
            reloadData()
        }
    }
    /// 老师模型
    var teacherModel: TeacherDetailModel?
    
    
    // MARK: - Instance Method
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Method
    private func configure() {
        delegate = self
        dataSource = self
        backgroundColor = UIColor.clear
        bounces = false
        isScrollEnabled = false
        
        register(ThemeShareCollectionViewCell.self, forCellWithReuseIdentifier: ThemeShareCollectionViewCellReuseId)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.section*2+indexPath.row
        let model = self.model[index]
        
        ThemeShare.hideShareBoard { 
            
        }
        
        println("分享按钮点击事件 \n \(teacherModel?.shareText) \n \(teacherModel?.avatar) \n \(teacherModel?.shareURL)")
        
        // 创建分享参数
        let shareParames = NSMutableDictionary()
        
        shareParames.ssdkSetupShareParams(byText: teacherModel?.shareText,
                                                images : (teacherModel?.avatar ?? UIImage(asset: .avatarPlaceholder)),
                                                url : teacherModel?.shareURL as URL!,
                                                title : "我在麻辣老师发现一位好老师！",
                                                type : SSDKContentType.webPage)
        // 进行分享
        ShareSDK.share(model.sharePlatformType, parameters: shareParames) { (state, userDate, entity, error) in
            switch state{
            case .success:
                println("分享成功")
            case .fail:
                println("分享失败,错误描述:\(error)")
            case .cancel:
                println("分享取消")
            default:
                break
            }
        }
    }
    
    
    // MARK: - DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeShareCollectionViewCellReuseId, for: indexPath) as! ThemeShareCollectionViewCell
        let index = indexPath.section*2+indexPath.row
        if index < model.count {
            cell.model = self.model[index]
        }
        return cell
    }
}


// MARK: - ThemeShareCollectionViewCell
class ThemeShareCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    /// 会员专享模型
    var model: IntroductionModel? {
        didSet {
            iconView.image = UIImage(asset: model?.image ?? .none)
            titleLabel.text = model?.title
        }
    }
    
    
    // MARK: - Compontents
    /// 图标
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    /// 标题标签
    private lazy var titleLabel: UILabel = {
        let label = UILabel(
            text: "",
            fontSize: 13,
            textColor: UIColor(named: .ArticleSubTitle)
        )
        label.textAlignment = .center
        return label
    }()
    private lazy var background: UIView = {
        let view = UIView(UIColor.white)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
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
        contentView.backgroundColor = UIColor.clear
        
        // SubViews
        contentView.addSubview(background)
        background.addSubview(iconView)
        contentView.addSubview(titleLabel)
        
        // Autolayout
        background.snp.makeConstraints { (maker) in
            maker.top.equalTo(contentView)
            maker.centerX.equalTo(contentView)
            maker.height.equalTo(55)
            maker.width.equalTo(55)
        }
        iconView.snp.makeConstraints { (maker) -> Void in
            maker.center.equalTo(background)
            maker.width.equalTo(47)
            maker.height.equalTo(47)
        }
        titleLabel.snp.makeConstraints { (maker) -> Void in
            maker.centerX.equalTo(contentView)
            maker.height.equalTo(13)
            maker.top.equalTo(background.snp.bottom).offset(10)
            maker.bottom.equalTo(contentView)
        }
    }
}


class ThemeShareFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - Instance Method
    init(frame: CGRect) {
        super.init()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Method
    private func configure() {
        scrollDirection = .vertical
        let itemWidth: CGFloat = MalaLayout_CardCellWidth / 2
        let itemHeight: CGFloat = 78
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        headerReferenceSize = CGSize(width: 300, height: MalaScreenOnePixel)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
    }
}
