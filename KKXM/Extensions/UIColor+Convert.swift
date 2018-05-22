//  
//  UIColor+Convert.swift
//  LinLangWanAn
//
//  Created by WANAN_SKK on 2018/1/17.
//  Copyright © 2018年 WANAN_SKK. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    //MARK: - Public 
    
    /// 根据十六进制的Hex字符串生成Color
    ///
    /// - Parameter hexStr: 十六进制的颜色Hex字符串
    /// - Returns: UIColor
    public static func color(withHexString hexStr: String) -> UIColor? {
        let scanner = Scanner(string: hexStr)
                
        var hexNum: UInt32 = 0
        
        guard  scanner.scanHexInt32(&hexNum) else { return nil }
        
        return UIColor.color(withRGBHex: hexNum)
    }
    
    //MARK: - Private 
    
    private static func color(withRGBHex hex: UInt32) -> UIColor {
    
        let r = CGFloat((hex >> 16) & 0xFF) 
        let g = CGFloat((hex >> 8) & 0xFF) 
        let b = CGFloat((hex) & 0xFF) 
        
        return UIColor(red: r / 255.0, green: g / 255.0,blue: b / 255.0, alpha: 1.0)
    }
}
