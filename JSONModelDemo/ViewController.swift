//
//  ViewController.swift
//  JSONModelDemo
//
//  Created by JIANLE CHEN on 2021/6/22.
//

import UIKit

let CELL_IDENTIFIER = "UITableViewCell"

class ViewController: UIViewController{
        
    // MARK: - Get & Set
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: CELL_IDENTIFIER)
        return tableView
    }()
    
    lazy var dataSource: [String] = {
        var array = [String]()
        array.append("rxSwift")
        return array
    }()

    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Demo"
        setupUI()
        setupLayout()
    }
    
    // MARK: - SetupUI
    func setupUI() {
        view.addSubview(tableView)
    }
    
    // MARK: - layout
    func setupLayout() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource  {
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let textRxSwiftVC = RxSwftDemoController()
            self.navigationController?.pushViewController(textRxSwiftVC, animated: true)
        }
    }
}

