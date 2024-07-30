//
//  SwitchViewController.swift
//  RxSwiftPractice
//
//  Created by 조규연 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SwitchViewController: BaseViewController {
    private let simpleSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setSwitch()
    }
}

private extension SwitchViewController {
    func configureView() {
        view.addSubview(simpleSwitch)
        
        simpleSwitch.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setSwitch() {
        Observable.just(true)
            .bind(to: simpleSwitch.rx.isOn)
            .disposed(by: disposeBag)
    }
}
