//
//  ToolHomeViewController.swift
//  KKXM
//
//  Created by WANAN_SKK on 2018/4/9.
//  Copyright © 2018年 KK. All rights reserved.
//

import UIKit

class ToolHomeViewController: BaseViewController {

    private let tableView = UITableView().then {
        $0.tableFooterView = UIView()
        $0.register(ToolHomeCell.self, forCellReuseIdentifier: ToolHomeCell.indentifier)
        $0.separatorStyle = .none
        $0.estimatedRowHeight = ToolHomeCell.height
        $0.backgroundColor = UIColor(red:0.98, green:0.97, blue:0.98, alpha:1.00)
    }
    
    private var viewModel = ToolHomeViewModel()
    
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, KK_Tool>>?
            
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Tools"
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints({ (make) in
            make.edges.equalTo(0)
        })
                
        // set up        
        bindingView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Binding
    private func bindingView() {
        
        // Data Source
        self.tableView.delegate = self
        
        self.dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, KK_Tool>>(configureCell: { (_, tableView, indexPath, tool) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: ToolHomeCell.indentifier, for: indexPath) as! ToolHomeCell
            cell.tool = tool
            return cell
        })
        
        // View Model
        self.viewModel.getHomeTools()
            .bind(to: self.tableView.rx.items(dataSource: self.dataSource!))
            .disposed(by: disposebag)
    }
}

//MARK: - Table View Delegate

extension ToolHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(AccountListViewController(), animated: true)
        }
    }
}
