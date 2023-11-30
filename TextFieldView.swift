//
//  TextFieldView.swift
//  ToDoApp
//
//  Created by Caner Karabulut on 15.09.2023.
//

import UIKit

class TextFieldView: UITextField {
    init(placeHolder: String) {
        super.init(frame: .zero)
        attributedPlaceholder = NSMutableAttributedString(string: placeHolder, attributes: [.foregroundColor: UIColor.white])
        textColor = .white
        borderStyle = .none
    }
                   
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
   }
}
