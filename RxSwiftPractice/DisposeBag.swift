//
//  DisposeBag.swift
//  RxSwiftPractice
//
//  Created by 조규연 on 7/30/24.
//

import Foundation
import RxSwift

extension DisposeBag {
    func store(@DisposableBuilder builder: () -> [Disposable]) {
        builder().forEach { disposable in
            disposable.disposed(by: self)
        }
    }
}
