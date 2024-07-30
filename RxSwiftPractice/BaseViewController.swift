//
//  BaseViewController.swift
//  RxSwiftPractice
//
//  Created by 조규연 on 7/30/24.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
}

extension BaseViewController {
    func showAlert() {
        let alert = UIAlertController(title: "회원가입이 완료되었습니다.", message: nil, preferredStyle: .alert)
        let button = UIAlertAction(title: "확인", style: .default)
        alert.addAction(button)
        present(alert, animated: true)
    }
}
