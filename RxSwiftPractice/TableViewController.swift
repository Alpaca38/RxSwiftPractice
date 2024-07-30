//
//  TableViewController.swift
//  RxSwiftPractice
//
//  Created by 조규연 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class TableViewController: BaseViewController {
    private let simpleTableView = UITableView()
    private let simpleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setTableView()
    }
}

private extension TableViewController {
    func configureView() {
        view.addSubview(simpleTableView)
        view.addSubview(simpleLabel)
        
        simpleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        simpleTableView.snp.makeConstraints {
            $0.top.equalTo(simpleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setTableView() {
        simpleTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])
        
        disposeBag.store {
            items
                .bind(to: simpleTableView.rx.items) { (tableView, row, element) in
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                    cell.textLabel?.text = "\(element) @ row \(row)"
                    return cell
                }
            
            simpleTableView.rx.modelSelected(String.self)
                .map { "\($0)를 클릭했습니다." }
                .bind(to: simpleLabel.rx.text)
        }
    }
}
