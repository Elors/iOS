//
//  LearningReportAbilityImproveCell.swift
//  mala-ios
//
//  Created by 王新宇 on 16/5/19.
//  Copyright © 2016年 Mala Online. All rights reserved.
//

import UIKit
import Charts

class LearningReportAbilityImproveCell: MalaBaseReportCardCell {
    
    // MARK: - Property
    /// 提分点数据
    private var model: [SingleTopicScoreData] = MalaConfig.scoreSampleData() {
        didSet {
            resetData()
        }
    }
    override var asSample: Bool {
        didSet {
            if asSample {
                model = MalaConfig.scoreSampleData()
            }else {
                hideDescription()
                model = MalaSubjectReport.score_analyses
            }
        }
    }
    
    
    // MARK: - Components
    /// 图例布局视图
    private lazy var legendView: CombinedLegendView = {
        let view = CombinedLegendView()
        return view
    }()
    /// 组合统计视图（条形&折线）
    private lazy var combinedChartView: CombinedChartView = {
        
        let chartView = CombinedChartView()
        chartView.animate(xAxisDuration: 0.65)
        chartView.drawOrder = [
            CombinedChartView.DrawOrder.bar.rawValue,
            CombinedChartView.DrawOrder.line.rawValue
        ]
        
        chartView.descriptionText = ""
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
        chartView.dragEnabled = false
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = true
        
        let xAxis = chartView.xAxis
        xAxis.labelFont = UIFont.systemFont(ofSize: 8)
        xAxis.labelTextColor = MalaColor_5E5E5E_0
        xAxis.drawGridLinesEnabled = false
        xAxis.labelPosition = .bottom
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = UIFont.systemFont(ofSize: 10)
        leftAxis.labelTextColor = MalaColor_5E5E5E_0
        leftAxis.gridLineDashLengths = [2,2]
        leftAxis.gridColor = MalaColor_E6E9EC_0
        leftAxis.drawGridLinesEnabled = true
        leftAxis.axisMinValue = 0
        leftAxis.axisMaxValue = 100
        leftAxis.labelCount = 5
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = "%"
        leftAxis.valueFormatter = pFormatter
        
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
        return chartView
    }()
    
    
    // MARK: - Instance Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupUserInterface()
        resetData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Method
    private func configure() {
        titleLabel.text = "提分点分析"
        descDetailLabel.text = "学生对于圆的知识点、函数初步知识点和几何变换知识点能力突出，可减少习题数。实数可加强练习。"
        legendView.addLegend(image: "dot_legend", title: "平均分数")
        legendView.addLegend(image: "histogram_legend", title: "我的评分")
    }
    
    private func setupUserInterface() {
        // Style
        
        
        // SubViews
        layoutView.addSubview(combinedChartView)
        layoutView.addSubview(legendView)
        
        // Autolayout
        legendView.snp.makeConstraints { (maker) in
            maker.left.equalTo(descView)
            maker.right.equalTo(descView)
            maker.height.equalTo(12)
            maker.top.equalTo(layoutView.snp.bottom).multipliedBy(0.17)
        }
        combinedChartView.snp.makeConstraints { (maker) in
            maker.top.equalTo(legendView.snp.bottom)
            maker.left.equalTo(descView)
            maker.right.equalTo(descView)
            maker.bottom.equalTo(layoutView).multipliedBy(0.68)
        }
    }
    
    // 设置样本数据
    private func setupSampleData() {
        
    }
    
    // 重置数据
    private func resetData() {
        
        var aveScoreIndex = -1
        var myScoreIndex = -1
        
        // 设置折线图数据
        let lineVals = model.map({ (data) -> ChartDataEntry in
            aveScoreIndex += 1
            return ChartDataEntry(value: data.ave_score.doubleValue*100, xIndex: aveScoreIndex)
        })
        let lineDataSet = LineChartDataSet(yVals: lineVals, label: "")
        lineDataSet.setColor(MalaColor_82C9F9_0)
        lineDataSet.fillAlpha = 1
        lineDataSet.circleRadius = 6
        lineDataSet.mode = .cubicBezier
        lineDataSet.drawValuesEnabled = true
        lineDataSet.setDrawHighlightIndicators(false)
        let lineData = LineChartData()
        lineData.addDataSet(lineDataSet)
        lineData.setDrawValues(false)
        
        // 设置柱状图数据
        let barVals = model.map({ (data) -> ChartDataEntry in
            myScoreIndex += 1
            return BarChartDataEntry(value: data.my_score.doubleValue*100, xIndex: myScoreIndex)
        })
        let barDataSet = BarChartDataSet(yVals: barVals, label: "")
        barDataSet.drawValuesEnabled = true
        barDataSet.colors = MalaConfig.chartsColor()
        barDataSet.highlightEnabled = false
        barDataSet.barSpace = 0.4
        let barData = BarChartData()
        barData.addDataSet(barDataSet)
        barData.setDrawValues(false)
        
        // 设置组合图数据
        let data = CombinedChartData(xVals: getXVals())
        data.lineData = lineData
        data.barData = barData
        combinedChartView.data = data
    }
    
    // 获取X轴文字信息
    private func getXVals() -> [String] {
        
        /// 若当前数据无效，则使用默认数据
        guard model.count != 0 else {
            return MalaConfig.homeworkDataChartsTitle()
        }
        
        let xVals = model.map { (data) -> String in
            return data.name
        }
        return xVals
    }
    
    override func hideDescription() {
        descDetailLabel.text = "矩形为学生各模块分数，折线为所有学生平均分数。通过矩形和折线的上下关系可发现学生与平均分数之间的对比关系。"
    }
}

// MARK: - LegendView
open class CombinedLegendView: UIView {
    
    // MARK: - Property
    private var currentButton: UIButton?
    
    
    // MARK: - Constructed
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    open func addLegend(image imageName: String, title: String) -> UIButton {
        let button = UIButton()
        button.adjustsImageWhenHighlighted = false
        
        button.setImage(UIImage(named: imageName), for: UIControlState())
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        
        button.setTitle(title, for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.setTitleColor(MalaColor_5E5E5E_0, for: UIControlState())
        
        button.sizeToFit()
        self.addSubview(button)
        
        button.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(self.snp.centerY)
            maker.right.equalTo(currentButton?.snp.left ?? self.snp.right).offset(-13)
        }
        currentButton = button
        
        return button
    }
}
