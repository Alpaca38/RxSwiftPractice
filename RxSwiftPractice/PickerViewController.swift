//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by 조규연 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class PickerViewController: BaseViewController {
    private let simplePickerView = UIPickerView()
    private let simpleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setPickerView()
    }
}

private extension PickerViewController {
    func configureView() {
        view.addSubview(simplePickerView)
        view.addSubview(simpleLabel)
        
        simplePickerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        simpleLabel.snp.makeConstraints {
            $0.top.equalTo(simplePickerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    func setPickerView() {
        let items = Observable.just([
            "영화",
            "애니메이션",
            "드라마",
            "기타"
        ])
        
        disposeBag.store {
            items
                .bind(to: simplePickerView.rx.itemTitles) { (row, element) in
                    return element
                }
            
            simplePickerView.rx.modelSelected(String.self)
                .map { $0.description }
                .bind(to: simpleLabel.rx.text)
        }
    }
}
