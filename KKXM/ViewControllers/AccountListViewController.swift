//
//  AccountListViewController.swift
//  KKXM
//
//  Created by WANAN_SKK on 2018/4/10.
//  Copyright © 2018年 KK. All rights reserved.
//

import UIKit

class AccountListViewController: BaseViewController {
    
    private let tableView = UITableView().then { 
        $0.tableFooterView = UIView()
        $0.register(AccountListViewCell.self, forCellReuseIdentifier: AccountListViewCell.identifier)
        $0.estimatedRowHeight = AccountListViewCell.height
    }
    
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, Account>>?
    
    private var viewModel = AccountViewModel(account: nil)
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Keys"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(gotoNewAccountView))
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
                        
        bingView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - 
    
    private func bingView() {
        //DataSource
        
        self.dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Account>>(configureCell: { (_, tableView, indexPath, account) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountListViewCell.identifier, for: indexPath) as! AccountListViewCell
            cell.accessoryType = .disclosureIndicator
            cell.account = account
            return cell
        })
        
        // View Model
        
        self.viewModel.prepareAccounts()
            .bind(to: self.tableView.rx.items(dataSource: self.dataSource!))
            .disposed(by: disposebag)
        
        // Action
        
        self.tableView.rx.itemSelected
            .subscribe {[weak self] (indexPath) in
                self?.tableView.deselectRow(at: indexPath.element!, animated: true)
                
                let account = self?.viewModel.selectAccount(with: (indexPath.element?.row)!)
                self?.navigationController?.pushViewController(NewAccountViewController(account: account), animated: true)
            }
            .disposed(by: disposebag)
    }
    
    //MARK: - Action
    
    private func refreshTableView() {
        self.viewModel.prepareAccounts()
            .bind(to: self.tableView.rx.items(dataSource: self.dataSource!))
            .disposed(by: disposebag)
        
//        self.tableView
    }
    
    @objc private func gotoNewAccountView() {
        let newAccountVC = NewAccountViewController(account: nil)
        
        newAccountVC.didSubmitSuccessCompleted = {[weak self] in
            self?.refreshTableView()
        }
        
        self.navigationController?.pushViewController(newAccountVC, animated: true)
    }
}
