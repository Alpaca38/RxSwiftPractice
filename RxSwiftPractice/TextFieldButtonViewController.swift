//
//  TextField+ButtonViewController.swift
//  RxSwiftPractice
//
//  Created by 조규연 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class TextFieldButtonViewController: BaseViewController {
    private let simpleName = UITextField()
    private let simpleEmail = UITextField()
    private let simpleLabel = UILabel()
    private let signButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setSign()
    }
}

private extension TextFieldButtonViewController {
    func configureView() {
        view.addSubview(simpleName)
        view.addSubview(simpleEmail)
        view.addSubview(simpleLabel)
        view.addSubview(signButton)
        
        simpleName.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
        simpleName.backgroundColor = .systemRed
        
        simpleEmail.snp.makeConstraints {
            $0.top.equalTo(simpleName.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
        simpleEmail.backgroundColor = .systemBlue
        
        simpleLabel.snp.makeConstraints {
            $0.top.equalTo(simpleEmail.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        signButton.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        signButton.backgroundColor = .systemMint
    }
    
    func setSign() {
        disposeBag.store {
            Observable.combineLatest(simpleName.rx.text.orEmpty, simpleEmail.rx.text.orEmpty) { value1, value2 in
                return "name은 \(value1)이고, email은 \(value2)입니다."
            }
            .bind(to: simpleLabel.rx.text)
            
            simpleName.rx.text.orEmpty
                .map { $0.count < 4 }
                .bind(to: simpleEmail.rx.isHidden, signButton.rx.isHidden)
            
            simpleEmail.rx.text.orEmpty
                .map { $0.count > 4 }
                .bind(to: signButton.rx.isEnabled)
            
            signButton.rx.tap
                .bind(with: self) { owner, _ in
                    owner.showAlert(message: "회원가입이 완료되었습니다.")
                }
        }
    }
}
