//
//  CouponRulesPopupWindow.swift
//  mala-ios
//
//  Created by 王新宇 on 16/5/12.
//  Copyright © 2016年 Mala Online. All rights reserved.
//

import UIKit


open class CouponRulesPopupWindow: UIViewController, UITextViewDelegate {
    
    // MARK: - Property
    /// 自身强引用
    var strongSelf: CouponRulesPopupWindow?
    /// 遮罩层透明度
    let tBakcgroundTansperancy: CGFloat = 0.7
    /// 布局容器（窗口）
    var window = UIView()
    /// 内容视图
    var contentView: UIView?
    /// 单击背景close窗口
    var closeWhenTap: Bool = false
    /// 弹窗高度
    var windowHeight: CGFloat = 0
    
    // MARK: - Components
    /// 描述 文字背景
    private lazy var textBackground: UIImageView = {
        let textBackground = UIImageView(imageName: "aboutText_Background")
        return textBackground
    }()
    /// 描述标题
    private lazy var titleView: AboutTitleView = {
        let titleView = AboutTitleView()
        return titleView
    }()
    /// 描述label
    private lazy var descTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 13)
        textView.textColor = UIColor(named: .HeaderTitle)
        textView.isEditable = false
        return textView
    }()
    /// 提交按钮装饰线
    private lazy var buttonSeparatorLine: UIView = {
        let view = UIView(UIColor(named: .ThemeBlue))
        return view
    }()
    /// 提交按钮
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.later, for: UIControlState())
        button.setTitleColor(UIColor(named: .ThemeBlue), for: UIControlState())
        button.setTitleColor(UIColor(named: .DescGray), for: .disabled)
        button.setBackgroundImage(UIImage.withColor(UIColor(named: .WhiteTranslucent9)), for: UIControlState())
        button.setBackgroundImage(UIImage.withColor(UIColor(named: .HighlightGray)), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(CouponRulesPopupWindow.animateDismiss), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Constructed
    init() {
        super.init(nibName: nil, bundle: nil)
        view.frame = UIScreen.main.bounds
        setupUserInterface()
        
        // 持有自己强引用，使自己在外界没有强引用时依然存在。
        strongSelf = self
    }
    
    convenience init(title: String, desc: String) {
        self.init(contentView: UIView())
        self.titleView.title = title
        self.descTextView.text = desc
        
        self.windowHeight = CGFloat((desc.characters.count / 16)+2)*14 + 90 + 14 + 44
        self.windowHeight = windowHeight > MalaLayout_CouponRulesPopupWindowHeight ? MalaLayout_CouponRulesPopupWindowHeight : windowHeight
        self.window.snp.updateConstraints { (maker) in
            maker.height.equalTo(self.windowHeight)
        }
    }
    
    convenience init(contentView: UIView) {
        self.init()
        self.view.alpha = 0
        
        // 显示Window
        let window: UIWindow = UIApplication.shared.keyWindow!
        window.addSubview(view)
        window.bringSubview(toFront: view)
        view.frame = window.bounds
        // 设置属性
        self.contentView = contentView
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Override
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if closeWhenTap {
            // 若触摸点不位于Window视图，关闭弹窗
            if let point = touches.first?.location(in: window), !window.point(inside: point, with: nil) {
                closeAlert(0)
            }
        }
    }
    
    
    // MARK: - API
    open func show() {
        animateAlert()
    }
    
    open func close() {
        closeAlert(0)
    }
    
    
    // MARK: - Private Method
    private func setupUserInterface() {
        // Style
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: tBakcgroundTansperancy)
        window.backgroundColor = UIColor.white
        
        // SubViews
        view.addSubview(window)
        window.addSubview(confirmButton)
        confirmButton.addSubview(buttonSeparatorLine)
        window.addSubview(textBackground)
        window.addSubview(titleView)
        window.addSubview(descTextView)
        
        
        // Autolayout
        window.snp.makeConstraints { (maker) -> Void in
            maker.width.equalTo(MalaLayout_CommentPopupWindowWidth)
            maker.height.equalTo(windowHeight)
            maker.center.equalTo(view)
        }
        buttonSeparatorLine.snp.makeConstraints { (maker) in
            maker.height.equalTo(MalaScreenOnePixel)
            maker.left.equalTo(confirmButton)
            maker.right.equalTo(confirmButton)
            maker.top.equalTo(confirmButton)
        }
        confirmButton.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(window)
            maker.left.equalTo(window)
            maker.right.equalTo(window)
            maker.height.equalTo(44)
        }
        textBackground.snp.makeConstraints { (maker) -> Void in
            maker.top.equalTo(window).offset(18)
            maker.left.equalTo(window).offset(18)
            maker.right.equalTo(window).offset(-18)
            maker.bottom.equalTo(confirmButton.snp.top).offset(-18)
        }
        titleView.snp.makeConstraints { (maker) -> Void in
            maker.top.equalTo(textBackground).offset(18)
            maker.left.equalTo(textBackground)
            maker.right.equalTo(textBackground)
        }
        descTextView.snp.makeConstraints { (maker) -> Void in
            maker.top.equalTo(titleView.snp.bottom).offset(18)
            maker.left.equalTo(textBackground).offset(18)
            maker.right.equalTo(textBackground).offset(-18)
            maker.bottom.equalTo(textBackground).offset(-18)
        }
    }
    
    private func animateAlert() {
        view.alpha = 0;
        let originTransform = self.window.transform
        self.window.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.0);
        
        UIView.animate(withDuration: 0.35, animations: { () -> Void in
            self.view.alpha = 1.0
            self.window.transform = originTransform
        }) 
    }
    
    @objc private func animateDismiss() {
        UIView.animate(withDuration: 0.35, animations: { () -> Void in
            self.view.alpha = 0
            self.window.transform = CGAffineTransform()
        }, completion: { (bool) -> Void in
            self.closeAlert(0)
        })
    }
    
    private func closeAlert(_ buttonIndex: Int) {
        self.view.removeFromSuperview()
        // 释放自身强引用
        self.strongSelf = nil
    }
    
    
    // MARK: - Event Response
    @objc private func pressed(_ sender: UIButton!) {
        self.closeAlert(sender.tag)
    }
    
    @objc private func closeButtonDidTap() {
        close()
    }
}
