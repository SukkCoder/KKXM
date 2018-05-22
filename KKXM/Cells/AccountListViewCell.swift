//
//  AccountListViewCell.swift
//  Key
//
//  Created by WANAN_SKK on 2018/3/23.
//  Copyright © 2018年 WANAN_SKK. All rights reserved.
//

import UIKit

class AccountListViewCell: UITableViewCell {
    
    static let height: CGFloat = 55.0
    static let identifier = "Account_List_Cell"
    
    var account: Account? {
        didSet {
            guard let account = account else { return }
            
            self.iconImageView.image = account.icon
            self.nameLabel.text = account.name
        }
    }
    
    private lazy var iconImageView: UIImageView = {
    
        let lazyIconImaeView = UIImageView()
        return lazyIconImaeView
    }()
        
    private lazy var nameLabel: UILabel = {

        let lazyNameLabel = UILabel()
        return lazyNameLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.iconImageView)
        self.contentView.addSubview(self.nameLabel)
        
        self.iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(self.contentView)
            make.height.width.equalTo(35)
        }
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.height.equalTo(30)
            make.left.equalTo(self.iconImageView.snp.right).offset(15)
            make.right.equalTo(-15)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
