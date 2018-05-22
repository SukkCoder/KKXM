//
//  AccountViewModel.swift
//  KKXM
//
//  Created by WANAN_SKK on 2018/4/10.
//  Copyright © 2018年 KK. All rights reserved.
//

import Foundation
import SQLite

struct AccountViewModel {
    
    public var account: Account?
    
    public var accountValues: [String : Any]? {
        get {
            guard let acc = account else { return nil }
            
            let values: [String : Any] = ["username":acc.username,
                                          "password":acc.password,
                                          "icon":acc.icon,
                                          "name":acc.name,
                                          "notes":acc.notes]
            return values
        }
    } 
    
    private var db: Connection!
    
    //MARK: - Init
    
    init(account: Account?) {
        self.account = account
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        
        do {
            db = try Connection(path! + "/db.sqlite3")
            print("与数据库建立链接成功。数据库路径: \(path! + "/db.sqlite3")")
        } catch {
            print("与数据库建立链接失败。错误: \(error)")
        }
        
        creatAccountTable()
    }
    
    //MARK: - Data
    
    //MARK: - Accout Table
    
    private let accountTable = Table("myAccounts")
    private let id = Expression<Int>("id")
    private let name = Expression<String>("name")
    private let username = Expression<String>("username")
    private let password = Expression<String>("password")
    private let icon = Expression<UIImage>("icon")
    private let notes = Expression<String>("notes")
    
    private func creatAccountTable() {
        do {
            try db.run(accountTable.create(block: { (table) in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(username)
                table.column(password)
                table.column(icon)
                table.column(notes)
            }))
            print("创建Account表成功")
        } catch {
            print("创建Account表失败:\(error)")
        }
    }
    
    //MARK: - 表操作
    
    func prepareAccounts() -> Observable<[SectionModel<String, Account>]> {
        var tempAccounts = [Account]()
        
        do {
            let accountsRows = try db.prepare(accountTable)
            
            for account in accountsRows {
                
                let aAccount: Account = Account(userId: account[id] as Int, 
                                                username: account[username] as String, 
                                                password: account[password] as String, 
                                                icon: account[icon] as UIImage, 
                                                name: account[name] as String,
                                                notes: account[notes] as String)
                tempAccounts.append(aAccount)
            }
            
            print("查询Account表成功，查询到\(tempAccounts.count)条数据")
        } catch {
            print("查询失败:\(error)")
        }
        
        return Observable.create({ (observer) -> Disposable in            
            let section = SectionModel(model: "", items: tempAccounts)
            
            observer.onNext([section])
            observer.onCompleted()
            
            return Disposables.create {}
        })
    }
    
    func selectAccount(with index: Int) -> Account? {
        var tempAccounts = [Account]()        
        
        do {
            let accountsRows = try db.prepare(accountTable)
                        
            for account in accountsRows {
                
                let aAccount: Account = Account(userId: account[id] as Int, 
                                                username: account[username] as String, 
                                                password: account[password] as String, 
                                                icon: account[icon] as UIImage, 
                                                name: account[name] as String,
                                                notes: account[notes] as String)
                tempAccounts.append(aAccount)
            }
            
            print("查询Account成功，查询到\(tempAccounts[index])")
            
            return tempAccounts[index]
            
        } catch {
            print("查询失败:\(error)")
            
            return nil
        }
    }
    
    func updateAccount(with formValues: [String : Any?]) {
        guard let userId = self.account!.userId else {
            SVProgressHUD.showError(withStatus: "userId 为空，不能更新操作")
            return
        }
        
        let accountRow = accountTable.filter(id == userId)
        
        let update = accountRow.update(name <- formValues["name"] as! String,
                                       username <- formValues["username"] as! String,
                                       password <- formValues["password"] as! String,
                                       icon <- formValues["icon"] as! UIImage,
                                       notes <- formValues["notes"] as! String)
        do {
            try db.run(update)
            print("更新成功")
        } catch {
            print("更新错误：\(error)")
        }
    }
    
    func insertAccount(with formValues: [String : Any?]) {
        let insert = accountTable.insert(name <- formValues["name"] as! String,
                                         username <- formValues["username"] as! String,
                                         password <- formValues["password"] as! String,
                                         icon <- formValues["icon"] as! UIImage,
                                         notes <- formValues["notes"] as! String)
        do {
            try db.run(insert)
            print("插入数据库成功")
        } catch  {
            print("插入数据库失败:\(error)")
        }
    }
}

extension UIImage: Value {
    public class var declaredDatatype: String {
        return Blob.declaredDatatype
    }
    public class func fromDatatypeValue(_ blobValue: Blob) -> UIImage {
        return UIImage(data: Data.fromDatatypeValue(blobValue))!
    }
    public var datatypeValue: Blob {
        return UIImagePNGRepresentation(self)!.datatypeValue
    }
}
