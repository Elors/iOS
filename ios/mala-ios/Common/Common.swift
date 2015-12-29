//
//  Common.swift
//  mala-ios
//
//  Created by Elors on 15/12/17.
//  Copyright © 2015年 Mala Online. All rights reserved.
//

import UIKit

// MARK: - Appearance TintColor
let MalaAppearanceTintColor = UIColor.redColor()
let MalaAppearanceTextColor = UIColor.whiteColor()


// MARK: - Common String
let MalaCommonString_Malalaoshi = "麻辣老师"
let MalaCommonString_Profile = "个人"


// MARK: - Common Proportion
let MalaProportion_HomeCellWidthWithScreenWidth: CGFloat = 0.47
let MalaProportion_HomeCellMarginWithScreenWidth: CGFloat = 0.02
let MalaProportion_HomeCellHeightWithWidth: CGFloat = 1.28


// MARK: - Device
let MalaScreenWidth = UIScreen.mainScreen().bounds.size.width
let MalaScreenHeight = UIScreen.mainScreen().bounds.size.height
// ScreenHeight Without StatusBar,NavigationBar,TabBar
let MalaContentHeight = UIScreen.mainScreen().bounds.size.height-20-44-48


// MARK: - Common TextAttribute
public func commonTextStyle() -> [String: AnyObject]? {
    let AttributeDictionary = NSMutableDictionary()
    AttributeDictionary[NSForegroundColorAttributeName] = UIColor.whiteColor()
    return AttributeDictionary.copy() as? [String : AnyObject]
}


// MARK: - TitleFilter
let MalaSubject = [
    1:"语文",
    2:"数学",
    3:"英语",
    4:"物理",
    5:"化学",
    6:"生物",
    7:"历史",
    8:"地理",
    9:"政治"
]

// MARK: - Grades
class MalaGrades {

    // MARK: - Variable
    private lazy var grades: [GradeModel] = []
    // Singleton
    private init() {
        let tempArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("FilterCondition.plist", ofType: nil)!) as? [AnyObject]

        for object in tempArray! {
            if let dict = object as? [String: AnyObject] {
                let set = GradeModel(dict: dict)
                grades.append(set)
            }
        }
    }
    static let instance = MalaGrades()

    var data: [GradeModel] {
        return grades
    }
}

// MARK: - TeacherTags
class MalaTeacherTags {

    // MARK: - Variable
    private lazy var tags: [GradeModel] = []
    private lazy var tagsDict: [Int: String] = [:]
    // Singleton
    private init() {

    }
    static let instance = MalaTeacherTags()

    func importData(tags: [GradeModel]?) {
        if tags == nil {
            return
        }
        for tag in tags! {
            tagsDict[tag.id] = tag.name
        }
    }
    var data: [Int: String] {
        get {
            return tagsDict
        }
    }
}
