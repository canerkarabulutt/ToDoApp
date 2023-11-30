//
//  AuthInputView.swift
//  ToDoApp
//
//  Created by Caner Karabulut on 15.09.2023.
//

import UIKit

class AuthInputView: UIView {
    init(image: UIImage,textField: UITextField) {
         super.init(frame: .zero)
         backgroundColor = .clear
         
         let imageView = UIImageView()
         imageView.clipsToBounds = true
         imageView.contentMode = .scaleAspectFill
         imageView.image = image
         imageView.tintColor = .white
         imageView.translatesAutoresizingMaskIntoConstraints = false
         addSubview(imageView)
         
         textField.translatesAutoresizingMaskIntoConstraints = false
         addSubview(textField)
        
        let dividerView = UIView()
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .white
        addSubview(dividerView)
                 
         NSLayoutConstraint.activate([
             imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
             imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
             imageView.heightAnchor.constraint(equalToConstant: 28),
             imageView.widthAnchor.constraint(equalToConstant: 28),
             
             textField.centerYAnchor.constraint(equalTo: centerYAnchor),
             textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
             textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
             trailingAnchor.constraint(equalTo: textField.trailingAnchor),
             
             dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
             dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
             dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
             dividerView.heightAnchor.constraint(equalToConstant: 0.7)
         ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
