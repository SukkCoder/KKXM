//
//  UIDevice+Type.swift
//  KKXM
//
//  Created by WANAN_SKK on 2018/4/10.
//  Copyright © 2018年 KK. All rights reserved.
//

import UIKit

enum UIDeviceScreenType {
    case iPhoneX, iPhonePlus, iPhoneNormal, iPhoneSE, iPhone4, Unknown
}

extension UIDevice {
    
    /** Current Device Screen Type */
    static var currentDeviceScreenType: UIDeviceScreenType {
        get {
            if let curDeviceSize = UIScreen.main.currentMode?.size {
                if curDeviceSize.equalTo(CGSize(width: 1125, height: 2436)) {
                    return UIDeviceScreenType.iPhoneX
                } else if curDeviceSize.equalTo(CGSize(width: 1242, height: 2208)) {
                    return UIDeviceScreenType.iPhonePlus
                } else if curDeviceSize.equalTo(CGSize(width: 750, height: 1334)) {
                    return UIDeviceScreenType.iPhoneNormal
                } else if curDeviceSize.equalTo(CGSize(width: 640, height: 1136)) {
                    return UIDeviceScreenType.iPhoneSE
                } else if curDeviceSize.equalTo(CGSize(width: 640, height: 960)) {
                    return UIDeviceScreenType.iPhone4
                } else {
                    return UIDeviceScreenType.Unknown
                }
            } else {
                return UIDeviceScreenType.Unknown
            }
        }
    }
}
