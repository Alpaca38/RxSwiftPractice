//
//  PointButton.swift
//  RxSwiftPractice
//
//  Created by 조규연 on 7/31/24.
//

import UIKit

final class PointButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        self.setAttributedTitle(NSAttributedString(string: title, attributes: [.font: UIFont.boldSystemFont(ofSize: 16)]), for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
