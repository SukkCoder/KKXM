//
//  ToolHomeViewModel.swift
//  KKXM
//
//  Created by WANAN_SKK on 2018/4/9.
//  Copyright © 2018年 KK. All rights reserved.
//

import Foundation

struct ToolHomeViewModel {
    
    func getHomeTools() -> Observable<[SectionModel<String, KK_Tool>]> {
            
        return Observable.create({ (observer) -> Disposable in
            
            let keyTool = KK_Tool(name: "Keys", 
                                  icon: #imageLiteral(resourceName: "tool_key"), 
                                  desc: "记录着注册过的网站或者App的账号和密码，只有本人和女朋友能打开！")
            let tipTool = KK_Tool(name: "Tips", 
                                  icon: #imageLiteral(resourceName: "tool_tip"), 
                                  desc: "什么时间什么地点需要提醒你做什么事儿，来着设置就对了，到了那个时间那个点就会提醒你。")
            
            let section = [SectionModel(model: "", items: [keyTool, tipTool])]
            
            observer.onNext(section)
            observer.onCompleted()
            
            return Disposables.create {}
        })
    }
}
