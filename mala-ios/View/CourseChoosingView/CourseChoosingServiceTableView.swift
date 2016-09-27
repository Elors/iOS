//
//  CourseChoosingServiceTableView.swift
//  mala-ios
//
//  Created by 王新宇 on 2/18/16.
//  Copyright © 2016 Mala Online. All rights reserved.
//

import UIKit

private let CourseChoosingServiceTableViewCellReuseId = "CourseChoosingServiceTableViewCellReuseId"

class CourseChoosingServiceTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Property
    var services: [OtherServiceModel] = MalaOtherService
    
    // MARK: - Constructed
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Method
    private func configure() {
        delegate = self
        dataSource = self
        bounces = false
        separatorColor = MalaColor_E5E5E5_0
        registerClass(CourseChoosingServiceTableViewCell.self, forCellReuseIdentifier: CourseChoosingServiceTableViewCellReuseId)
        
    }
    
    
    // MARK: - Delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return MalaLayout_OtherServiceCellHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 跳转到对应的ViewController
        if let type = (services[indexPath.row].viewController) as? UIViewController.Type {
            let viewController = type.init()
            (viewController as? CouponViewController)?.justShow = false
            (viewController as? CouponViewController)?.onlyValid = true
            viewController.hidesBottomBarWhenPushed = true
            self.viewController()?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    
    // MARK: - DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 若非首次购课，不显示第二项[建档测评服务]
        return MalaIsHasBeenEvaluatedThisSubject == true ? MalaOtherService.count : (MalaOtherService.count-1)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CourseChoosingServiceTableViewCellReuseId, forIndexPath: indexPath)
        (cell as! CourseChoosingServiceTableViewCell).service = self.services[indexPath.row]
        return cell
    }
}


// MARK: - CourseChoosingServiceTableViewCell
class CourseChoosingServiceTableViewCell: UITableViewCell {
    
    // MARK: Property
    var service: OtherServiceModel? {
        didSet{
            
            guard let model = service else {
                return
            }
            
            if model.type == .Coupon {
                configure()
            }
            
            self.titleLabel.text = service?.title

            if let amount = MalaCurrentCourse.coupon?.amount where amount != 0 {
                updateUserInterface()
                return
            }
            
            switch model.priceHandleType {
            case .Discount:
                
                self.priceHandleLabel.text = model.price?.priceCNY == nil ? "" : "-"
                self.priceLabel.text = model.price?.priceCNY
                break
                
            case .Reduce:
                
                let oldPrice = String(format: "￥%d", (model.price ?? 0))
                let attr = NSMutableAttributedString(string: oldPrice)
                attr.addAttribute(NSStrikethroughStyleAttributeName, value: NSNumber(integer: 1), range: NSMakeRange(0, oldPrice.characters.count))
                self.priceHandleLabel.attributedText = attr
                self.priceLabel.text = String(format: "￥%d", 0)
                break
                
            case .None:
                
                self.priceHandleLabel.text = ""
                self.priceLabel.text = "不使用奖学金"
                break
            }
        }
    }
    private var myContext = 0
    private var didAddObserve = false
    
    
    // MARK: - Components
    /// 标题Label
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = MalaColor_6C6C6C_0
        return label
    }()
    /// 右箭头标示
    private lazy var detailImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "rightArrow"))
        return imageView
    }()
    /// 价格Label
    private lazy var priceLabel: UILabel = {
        let label = UILabel(
            text: "",
            fontSize: 14,
            textColor: MalaColor_333333_0
        )
        return label
    }()
    /// 价格处理Label
    private lazy var priceHandleLabel: UILabel = {
        let label = UILabel(
            text: "",
            fontSize: 14,
            textColor: MalaColor_333333_0
        )
        return label
    }()
    
    
    // MARK: - Constructed
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUserInterface()
        updateUserInterface()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Method
    private func setupUserInterface() {
        // Style
        selectionStyle = .None
        separatorInset = UIEdgeInsetsZero
        layoutMargins = UIEdgeInsetsZero
        preservesSuperviewLayoutMargins = false
        
        // Subviews
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailImageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(priceHandleLabel)
        
        // Autolayout
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentView.snp_left)
            make.height.equalTo(14)
            make.centerY.equalTo(contentView.snp_centerY)
        }
        detailImageView.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(contentView.snp_right)
            make.centerY.equalTo(contentView.snp_centerY)
        }
        priceLabel.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(14)
            make.right.equalTo(detailImageView.snp_left).offset(-6)
            make.centerY.equalTo(contentView.snp_centerY)
        }
        priceHandleLabel.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(14)
            make.right.equalTo(priceLabel.snp_left).offset(-6)
            make.centerY.equalTo(contentView.snp_centerY)
        }
    }
    
    private func configure() {
        MalaCurrentCourse.addObserver(self, forKeyPath: "coupon", options: .New, context: &myContext)
        didAddObserve = true
    }
    
    
    // MARK: - Override
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        // 选择优惠券时更新UI
        updateUserInterface()
    }
    
    private func updateUserInterface() {
        
        // 选择优惠券时更新UI
        if let title = MalaCurrentCourse.coupon?.name where title == "不使用奖学金" {
            self.priceHandleLabel.text = ""
            self.priceLabel.text = "不使用奖学金"
        }else if let amount = MalaCurrentCourse.coupon?.amount where amount != 0 {
            self.priceHandleLabel.text = "-"
            self.priceLabel.text = MalaCurrentCourse.coupon?.amount.priceCNY
        }else {
            self.priceHandleLabel.text = ""
            self.priceLabel.text = "不使用奖学金"
        }
        
        if let title = MalaCurrentCourse.coupon?.name where title != "" {
            self.titleLabel.text = title
        }else {
            self.titleLabel.text = "奖学金"
        }
    }
    

    deinit {
        if didAddObserve {
            MalaCurrentCourse.removeObserver(self, forKeyPath: "coupon", context: &myContext)
        }
    }
}
