//
//  ToolHomeCell.swift
//  KKXM
//
//  Created by WANAN_SKK on 2018/4/9.
//  Copyright © 2018年 KK. All rights reserved.
//

import UIKit

class ToolHomeCell: UITableViewCell {
    
    static let indentifier = "Tool_Home_Cell"
    static let height: CGFloat = 85.0
    // hahahahahhahahahah
    var tool: KK_Tool? {
        didSet {
            guard let tool = tool else { return }
            
            self.iconView.image = tool.icon
            self.nameLabel.text = tool.name
            self.descLabel.text = tool.desc
        }
    }
    
    private lazy var backView: UIView = {
        let lazyBackView = UIView()
        lazyBackView.backgroundColor = .white
        lazyBackView.layer.cornerRadius = 5.0
        lazyBackView.layer.masksToBounds = true
        return lazyBackView
    }()
    
    private lazy var iconView: UIImageView = {
        let lazyIconView = UIImageView()
        return lazyIconView
    }()
    
    private lazy var nameLabel: UILabel = {
        let lazyNameLabel = UILabel()
        lazyNameLabel.font = UIFont.systemFont(ofSize: UIFont.buttonFontSize)
        return lazyNameLabel
    }()
    
    private lazy var descLabel: UILabel = {
        let lazyDescLabel = UILabel()
        lazyDescLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        lazyDescLabel.textColor = .gray
        lazyDescLabel.numberOfLines = 0
        return lazyDescLabel
    }()

    //Override init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = kViewBaseBackgroundColor
        
        self.contentView.addSubview(self.backView)
        self.backView.addSubview(self.iconView)
        self.backView.addSubview(self.nameLabel)
        self.backView.addSubview(self.descLabel)
        
        self.backView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(10, 10, 0, 10))
        }
        
        self.iconView.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.centerY.equalTo(self.backView)
            make.height.width.equalTo(45)
        }
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.height.equalTo(20)
            make.left.equalTo(self.iconView.snp.right).offset(10)
            make.right.equalTo(self.backView.snp.right).offset(-15)
        }
        
        self.descLabel.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.nameLabel)
            make.top.equalTo(self.nameLabel.snp.bottom).offset(10)
            make.bottom.equalTo(self.backView.snp.bottom).offset(-10)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
