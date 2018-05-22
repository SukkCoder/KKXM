//
//  BaseViewController.swift
//  KKXM
//
//  Created by WANAN_SKK on 2018/4/10.
//  Copyright © 2018年 KK. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    //MARK: - Rx
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = kViewBaseBackgroundColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
