//
//  Macaro.swift
//  KKXM
//
//  Created by WANAN_SKK on 2018/4/10.
//  Copyright © 2018年 KK. All rights reserved.
//

import Foundation
import UIKit
@_exported import RxSwift
@_exported import Then
@_exported import SnapKit
@_exported import RxDataSources
@_exported import SVProgressHUD

//MARK: - Color

let kViewBaseBackgroundColor = UIColor(red:0.98, green:0.97, blue:0.98, alpha:1.00)

//MARK: - 

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

///iPhone X的底部 Home Indicator 高度
let kHomeIndicatorHeight: CGFloat = 34.0
var kStatusBarHeight: CGFloat {
    if UIDevice.currentDeviceScreenType == UIDeviceScreenType.iPhoneX {
        return 44.0
    } else {
        return 20.0
    }
}
