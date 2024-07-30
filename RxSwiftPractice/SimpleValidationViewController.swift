//
//  SimpleValidationViewController.swift
//  RxSwiftPractice
//
//  Created by 조규연 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

final class SimpleValidationViewController: BaseViewController {
    private let usernameOutlet = UITextField()
    private let usernameValidOutlet = UILabel()
    private let passwordOutlet = UITextField()
    private let passwordValidOutlet = UILabel()
    private let doSomethingOutlet = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setValidation()
    }
}

private extension SimpleValidationViewController {
    func configureView() {
        view.addSubview(usernameOutlet)
        view.addSubview(usernameValidOutlet)
        view.addSubview(passwordOutlet)
        view.addSubview(passwordValidOutlet)
        view.addSubview(doSomethingOutlet)
        
        usernameOutlet.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(34)
        }
        usernameOutlet.placeholder = "Username"
        
        usernameValidOutlet.snp.makeConstraints {
            $0.top.equalTo(usernameOutlet.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(usernameOutlet)
        }
        
        passwordOutlet.snp.makeConstraints {
            $0.top.equalTo(usernameValidOutlet.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(usernameOutlet)
            $0.height.equalTo(34)
        }
        passwordOutlet.placeholder = "Password"
        
        passwordValidOutlet.snp.makeConstraints {
            $0.top.equalTo(passwordOutlet.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(usernameOutlet)
        }
        
        doSomethingOutlet.snp.makeConstraints {
            $0.top.equalTo(passwordValidOutlet.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(usernameOutlet)
            $0.height.equalTo(44)
        }
        doSomethingOutlet.backgroundColor = .systemCyan
    }
    
    func setValidation() {
        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"

        let usernameValid = usernameOutlet.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1) // without this map would be executed once for each binding, rx is stateless by default

        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)

        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)

        usernameValid
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)

        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)

        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)

        everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)

        doSomethingOutlet.rx.tap
            .bind(with: self, onNext: { owner, _ in
                owner.showAlert()
            })
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
