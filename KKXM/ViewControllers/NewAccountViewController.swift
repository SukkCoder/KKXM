//
//  NewAccountViewController.swift
//  KKXM
//
//  Created by WANAN_SKK on 2018/4/10.
//  Copyright © 2018年 KK. All rights reserved.
//

import Eureka

class NewAccountViewController: FormViewController {
    
    public var didSubmitSuccessCompleted: (() -> Void)?
    
    private var viewModel: AccountViewModel!
        
    //MARK: - Life cycle
    
    init(account: Account?) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = AccountViewModel.init(account: account)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "New Account"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(submitAccountData))
        
        form
        
        +++ Section("Account Icon")
            
            <<< ImageRow("icon") {
                $0.title = "Icon:"
            }
            
        +++ Section("Account Info")
        
            <<< TextRow("name") {
                $0.title = "Name:"
                $0.placeholder = "Please input Name"
            }
            
            <<< TextRow("username") {
                $0.title = "Username:"
                $0.placeholder = "Please input Username"
            }
            
            <<< TextRow("password") {
                $0.title = "Password:"
                $0.placeholder = "Please input Password"
            }
            
        +++ Section("Remark")
            
            <<< TextRow("notes") {
                $0.title = "Remark:"
                $0.placeholder = "Please input Remark"
            }
        
        // Set Values
        if let accValues = self.viewModel.accountValues {
            form.setValues(accValues)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Action
    
    @objc private func submitAccountData() {
        print(form.values())
        
        for (key, value) in form.values() {
            if value == nil {
                                
                let alert: UIAlertController = UIAlertController(title: "提示", message: "\(key) cannot nil", preferredStyle: .alert) 
                alert.addAction(UIAlertAction(title: "知道了", style: .default, handler: { (aciton) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
                
                return
            }
        }
        
        if self.viewModel.account == nil {
            self.viewModel.insertAccount(with: form.values())
        } else {
            self.viewModel.updateAccount(with: form.values())
        }
        
        self.navigationController?.popViewController(animated: true)        
    }
}
