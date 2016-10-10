//
//  LearningReportHomeworkDataCell.swift
//  mala-ios
//
//  Created by 王新宇 on 16/5/19.
//  Copyright © 2016年 Mala Online. All rights reserved.
//

import UIKit
import Charts

class LearningReportHomeworkDataCell: MalaBaseCardCell {
    
    // MARK: - Property
    /// 作业数据
    private var model: [SingleHomeworkData] = MalaConfig.homeworkSampleData() {
        didSet {
            resetData()
        }
    }
    override var asSample: Bool {
        didSet {
            model = asSample ? MalaConfig.homeworkSampleData() : MalaSubjectReport.error_rates
            
            if asSample {
                infoLabel.text = "累计答题770道"
                homeworkLabel.text = "准确率80%"
            }else {
                infoLabel.text = String(format: "累计答题%d道", Int(MalaReportTotalNum))
                if MalaReportTotalNum != 0 {
                    homeworkLabel.text = String(format: "准确率%.2f%%", Float(MalaReportRightNum/MalaReportTotalNum))
                }else {
                    homeworkLabel.text = "准确率0%"
                }
            }
        }
    }
    
    
    // MARK: - Components
    /// 标题标签
    private lazy var titleLabel: UILabel = {
        let label = UILabel(
            text: "作业数据分析",
            fontSize: 16,
            textColor: MalaColor_5E5E5E_0
        )
        return label
    }()
    /// 分割线
    private lazy var separatorLine: UIView = {
        let view = UIView.separator(MalaColor_EDEDED_0)
        return view
    }()
    /// 学习信息标签
    private lazy var infoLabel: UILabel = {
        let label = UILabel(
            text: "",
            fontSize: 10,
            textColor: MalaColor_5E5E5E_0
        )
        label.backgroundColor = MalaColor_E8F2F8_0
        label.textAlignment = .center
        label.layer.cornerRadius = 11
        label.layer.masksToBounds = true
        return label
    }()
    /// 皇冠头像图片
    private lazy var infoIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "reportTitle_icon"))
        return imageView
    }()
    /// 作业信息标签
    private lazy var homeworkLabel: UILabel = {
        let label = UILabel(
            text: "",
            fontSize: 10,
            textColor: MalaColor_8DBEDE_0
        )
        return label
    }()
    /// 饼形统计视图
    private lazy var pieChartView: PieChartView = {
        let pieChartView = PieChartView()
        
        pieChartView.centerText = "错题分布"
        pieChartView.holeRadiusPercent = 0.4
        pieChartView.animate(xAxisDuration: 0.65)
        
        pieChartView.usePercentValuesEnabled = true
        pieChartView.drawSliceTextEnabled = false
        pieChartView.rotationEnabled = false
        pieChartView.legend.enabled = false
        pieChartView.descriptionText = ""
        return pieChartView
    }()
    /// 图例容器
    private lazy var legendView: PieLegendView = {
        let view = PieLegendView()
        return view
    }()

    
    // MARK: - Instance Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupUserInterface()
        setupSampleData()
        resetData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Method
    private func configure() {
        // X轴数据
        let xVals = model.map { (data) -> String in
            return data.name
        }
        
        // 加载图例
        legendView.removeAllLegend()
        for (index, string) in xVals.enumerated() {
            legendView.addLegend(color: MalaConfig.chartsColor()[index], title: string)
        }
    }
    
    private func setupUserInterface() {
        // Style
        contentView.backgroundColor = MalaColor_F2F2F2_0
        
        // SubViews
        layoutView.addSubview(titleLabel)
        layoutView.addSubview(separatorLine)
        layoutView.addSubview(infoLabel)
        layoutView.addSubview(infoIcon)
        layoutView.addSubview(homeworkLabel)
        layoutView.addSubview(pieChartView)
        layoutView.addSubview(legendView)
        
        
        // Autolayout
        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.centerX.equalTo(layoutView.snp.centerX)
            make.top.equalTo(layoutView.snp.bottom).multipliedBy(0.05)
        }
        separatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(layoutView.snp.bottom).multipliedBy(0.13)
            make.height.equalTo(MalaScreenOnePixel)
            make.centerX.equalTo(layoutView.snp.centerX)
            make.width.equalTo(layoutView.snp.width).multipliedBy(0.84)
        }
        infoLabel.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(22)
            make.centerX.equalTo(layoutView.snp.centerX)
            make.top.equalTo(layoutView.snp.bottom).multipliedBy(0.17)
        }
        infoIcon.snp.makeConstraints { (make) in
            make.bottom.equalTo(infoLabel.snp.bottom)
            make.left.equalTo(infoLabel.snp.left)
            make.width.equalTo(22.5)
            make.height.equalTo(33)
        }
        homeworkLabel.snp.makeConstraints { (make) in
            make.top.equalTo(layoutView.snp.bottom).multipliedBy(0.23)
            make.height.equalTo(12)
            make.centerX.equalTo(layoutView.snp.centerX)
        }
        pieChartView.snp.makeConstraints { (make) in
            make.top.equalTo(homeworkLabel.snp.bottom)
            make.left.equalTo(layoutView.snp.left).offset(27)
            make.right.equalTo(layoutView.snp.right).offset(-27)
            make.height.equalTo(pieChartView.snp.width)//.offset(100)
        }
        legendView.snp.makeConstraints { (make) in
            make.top.equalTo(pieChartView.snp.bottom)
            make.left.equalTo(layoutView.snp.left).offset(27)
            make.right.equalTo(layoutView.snp.right).offset(-27)
            make.bottom.equalTo(layoutView.snp.bottom).multipliedBy(0.914)
        }
    }
    
    // 设置样本数据
    private func setupSampleData() {
        infoLabel.text = "累计答题0道"
        homeworkLabel.text = "准确率0%"
    }
    
    // 重置数据
    private func resetData() {
        
        guard model.count != 0 else {
            handleNullData()
            return
        }
        
        // Y轴数据
        let yVals = model.map { (data) -> ChartDataEntry in
            return ChartDataEntry(value: data.rate.doubleValue, xIndex: data.id)
        }
        // X轴数据
        let xVals = model.map { (data) -> String in
            return data.name
        }
        // 设置数据
        configure()
        let dataSet = PieChartDataSet(yVals: yVals, label: nil)
        dataSet.colors = MalaConfig.chartsColor()
        let data = PieChartData(xVals: xVals, dataSet: dataSet)
        
        // 设置数据显示格式
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = "%"
        data.setValueFormatter(pFormatter)
        data.setValueFont(UIFont.systemFont(ofSize: 11))
        data.setValueTextColor(UIColor.white)
        pieChartView.data = data
    }
    
    private func handleNullData() {
        
        // Y轴数据
        let yVals = ChartDataEntry(value: Double(1), xIndex: 0)
        
        // 设置空数据
        let dataSet = PieChartDataSet(yVals: [yVals], label: nil)
        dataSet.colors = [MalaColor_E5E5E5_3]
        let data = PieChartData(xVals: [""], dataSet: dataSet)
        pieChartView.data = data
    }
}



// MARK: - LegendView
open class PieLegendView: UIView {
    
    // MARK: - Property
    private var currentX: CGFloat = 6
    private var currentY: CGFloat = 0 {
        didSet {
            if currentY != oldValue {
                self.currentX = 6
            }
        }
    }
    var viewCount: Int = 0
    var legends: [UIButton] = []
    
    
    // MARK: - Constructed
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    open func addLegend(color: UIColor, title: String) -> UIButton {
        let button = UIButton()
        button.adjustsImageWhenHighlighted = false
        
        let image = UIImage.withColor(color, bounds: CGRect(x: 0, y: 0, width: 10, height: 10))
        button.setImage(image, for: UIControlState())
        button.imageView?.layer.cornerRadius = 5
        button.imageView?.layer.masksToBounds = true
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 6)
        
        button.setTitle(title, for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(MalaColor_939393_0, for: UIControlState())
        
        button.sizeToFit()
        currentY = CGFloat(Int(Int(self.viewCount)/3)*20)
        button.frame.origin.y = currentY
        currentX = CGFloat(Int(Int(self.viewCount)%3)*Int(MalaScreenWidth*0.35))
        button.frame.origin.x = currentX
        
        addSubview(button)
        viewCount += 1
        currentX = button.frame.maxX
        legends.append(button)
        
        return button
    }
    
    open func removeAllLegend() {
        currentX = 0
        currentY = 0
        viewCount = 0
        for legend in legends {
            legend.removeFromSuperview()
        }
    }
}
