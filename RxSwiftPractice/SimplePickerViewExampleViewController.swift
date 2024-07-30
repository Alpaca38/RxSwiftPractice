//
//  SimplePickerViewExampleViewController.swift
//  RxSwiftPractice
//
//  Created by 조규연 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SimplePickerViewExampleViewController: BaseViewController {
    private let pickerView1 = UIPickerView()
    private let pickerView2 = UIPickerView()
    private let pickerView3 = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setPickerView()
    }
}

private extension SimplePickerViewExampleViewController {
    func configureView() {
        view.addSubview(pickerView1)
        view.addSubview(pickerView2)
        view.addSubview(pickerView3)
        
        pickerView1.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
        pickerView2.snp.makeConstraints {
            $0.top.equalTo(pickerView1.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
        pickerView3.snp.makeConstraints {
            $0.top.equalTo(pickerView2.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
    }
    
    func setPickerView() {
        Observable.just([1, 2, 3])
            .bind(to: pickerView1.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)

        pickerView1.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("models selected 1: \(models)")
            })
            .disposed(by: disposeBag)
        
        Observable.just([1, 2, 3])
            .bind(to: pickerView2.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(string: "\(item)",
                                          attributes: [
                                            NSAttributedString.Key.foregroundColor: UIColor.cyan,
                                            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue
                                        ])
            }
            .disposed(by: disposeBag)

        pickerView2.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("models selected 2: \(models)")
            })
            .disposed(by: disposeBag)
        
        Observable.just([UIColor.red, UIColor.green, UIColor.blue])
            .bind(to: pickerView3.rx.items) { _, item, _ in // Int, Sequence.Element, UIView
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)

        pickerView3.rx.modelSelected(UIColor.self)
            .subscribe(onNext: { models in
                print("models selected 3: \(models)")
            })
            .disposed(by: disposeBag)
    }
}
