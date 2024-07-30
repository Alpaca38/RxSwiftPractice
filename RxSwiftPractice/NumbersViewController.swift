//
//  NumbersViewController.swift
//  RxSwiftPractice
//
//  Created by 조규연 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class NumbersViewController: BaseViewController {
    private let number1 = UITextField()
    private let number2 = UITextField()
    private let number3 = UITextField()
    
    private let result = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setNumbers()
    }
}

private extension NumbersViewController {
    func configureView() {
        view.addSubview(number3)
        view.addSubview(number2)
        view.addSubview(number1)
        view.addSubview(result)
        
        number3.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(97)
            $0.height.equalTo(30)
        }
        
        number2.snp.makeConstraints {
            $0.bottom.equalTo(number3.snp.top).offset(-8)
            $0.horizontalEdges.equalTo(number3)
            $0.height.equalTo(30)
        }
        
        number1.snp.makeConstraints {
            $0.bottom.equalTo(number2.snp.top).offset(-8)
            $0.horizontalEdges.equalTo(number3)
            $0.height.equalTo(30)
        }
        
        result.snp.makeConstraints {
            $0.top.equalTo(number3.snp.bottom).offset(8)
            $0.trailing.equalTo(number3)
            $0.leading.equalTo(number3).offset(-20)
        }
        
        number1.borderStyle = .roundedRect
        number2.borderStyle = .roundedRect
        number3.borderStyle = .roundedRect
        
        result.textAlignment = .right
    }
    
    func setNumbers() {
        Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
                return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
            }
            .map { $0.description }
            .bind(to: result.rx.text)
            .disposed(by: disposeBag)
    }
}
