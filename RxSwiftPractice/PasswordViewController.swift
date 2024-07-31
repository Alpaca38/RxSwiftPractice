//
//  PasswordViewController.swift
//  RxSwiftPractice
//
//  Created by 조규연 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class PasswordViewController: BaseViewController {
    private let passwordTextField = UITextField()
    private let nextButton = PointButton(title: "다음")
    private let descriptionLabel = UILabel()
    private let validText = Observable.just("8자 이상 입력해주세요.")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
}

private extension PasswordViewController {
    func configureView() {
        view.addSubview(passwordTextField)
        view.addSubview(nextButton)
        view.addSubview(descriptionLabel)
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom)
            $0.horizontalEdges.equalTo(passwordTextField)
            $0.height.equalTo(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(passwordTextField)
            $0.height.equalTo(50)
        }
    }
    
    func bind() {
        disposeBag.insert {
            validText
                .bind(to: descriptionLabel.rx.text)
            
            let validation = passwordTextField.rx.text.orEmpty
                .map { $0.count >= 8 }
            
            validation
                .bind(to: nextButton.rx.isEnabled, descriptionLabel.rx.isHidden)
            
            validation
                .bind(with: self) { owner, value in
                    let color: UIColor = value ? .systemPink : .lightGray
                    owner.nextButton.backgroundColor = color
                }
            
            nextButton.rx.tap
                .bind(with: self) { owner, _ in
                    print("show alert")
                }
        }
    }
}
