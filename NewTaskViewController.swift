//
//  NewTaskViewController.swift
//  ToDoApp
//
//  Created by Caner Karabulut on 17.09.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class NewTaskViewController: UIViewController {
    //MARK: - Properties
    private let newTaskLabel: UILabel = {
       let label = UILabel()
        label.attributedText = NSAttributedString(string: "New Task", attributes: [.foregroundColor: UIColor.white, .font: UIFont.preferredFont(forTextStyle: .largeTitle)])
        label.textAlignment = .center
        return label
    }()
    private let textView: InputTextView = {
       let inputTextView = InputTextView()
        inputTextView.placeHolder = "Enter New Task..."
        return inputTextView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return button
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Task", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .mainColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        return button
    }()
    
    private var stackView = UIStackView()
    
    //MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}
//MARK: - Selector
extension NewTaskViewController {
    @objc private func handleCancelButton() {
        self.dismiss(animated: true)
    }
    @objc private func handleAddButton() {
        guard let taskText = textView.text else { return }
        TaskService.sendTask(text: taskText) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        self.dismiss(animated: true)
    }
}
//MARK: - Helpers
extension NewTaskViewController {
    private func style() {
        view.backgroundColor = .black.withAlphaComponent(0.7)
        
        newTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView(arrangedSubviews: [cancelButton, addButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
    }
    private func layout() {
        view.addSubview(newTaskLabel)
        view.addSubview(textView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            //newTaskLabel layout
            newTaskLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            newTaskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            view.trailingAnchor.constraint(equalTo: newTaskLabel.trailingAnchor, constant: 32),
            newTaskLabel.heightAnchor.constraint(equalToConstant: 60),
            //textView layout
            textView.topAnchor.constraint(equalTo: newTaskLabel.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: 16),
            textView.heightAnchor.constraint(equalToConstant: view.bounds.height / 5),
            //stackView layout
            stackView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 16)
        ])
    }
}
