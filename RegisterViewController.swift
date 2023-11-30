//
//  RegisterViewController.swift
//  ToDoApp
//
//  Created by Caner Karabulut on 15.09.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK: - Properties
    private var profileImage: UIImage?
    
    private var viewModel = RegisterViewModel()
    private lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "person.circle"), for: .normal)
        button.tintColor = .white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        //add Picker
        button.addTarget(self, action: #selector(handlePhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let containerView = AuthInputView(image: UIImage(systemName: "envelope.fill")!, textField: emailTextField)
        return containerView
    }()
    
    private lazy var passwordContainerView: UIView = {
        let containerView = AuthInputView(image: UIImage(systemName: "lock.fill")!, textField: passwordTextField)
        return containerView
    }()
    
    private let emailTextField: UITextField = {
        let textField = TextFieldView(placeHolder: "Email")
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = TextFieldView(placeHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var nameContainerView: UIView = {
        let containerView = AuthInputView(image: UIImage(systemName: "person")!, textField: nameTextField)
        return containerView
    }()
    
    private lazy var usernameContainerView: UIView = {
        let containerView = AuthInputView(image: UIImage(systemName: "person")!, textField: usernameTextField)
        return containerView
    }()
    
    private let nameTextField: UITextField = {
        let textField = TextFieldView(placeHolder: "Name")
        return textField
    }()
    
    private let usernameTextField: UITextField = {
        let textField = TextFieldView(placeHolder: "Username")
        return textField
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.layer.cornerRadius = 7
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleRegisterButton), for: .touchUpInside)
        return button
    }()
    
    private var stackView = UIStackView()
    
    private lazy var goLogInPage: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "If you are a member, Login Page", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleGoLogIn), for: .touchUpInside)
        return button
    }()
    
    
    
    //MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
}
//MARK: - Selector
extension RegisterViewController {
    
    @objc private func handleKeyboardWillShow() {
        self.view.frame.origin.y = -110
    }
    
    @objc private func handleKeyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc private func handleRegisterButton(_ sender: UIButton) {
        guard let emailText = emailTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        guard let nameText = nameTextField.text else { return }
        guard let usernameText = usernameTextField.text else { return }
        guard let profileImage = self.profileImage else { return }
        
        showHud(show: true)
        
        let user = AuthRegisterUserModel(emailText: emailText, passwordText: passwordText, usernameText: usernameText, nameText: nameText, profileImage: profileImage)
        AuthService.createUser(user: user) { error in
            if let error = error {
                print("Error.. \(error.localizedDescription)")
                self.showHud(show: false)
                return
            }
            self.showHud(show: false)
            self.dismiss(animated: true)
        }
    }
    
    @objc private func handlePhoto(_ sender:UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    @objc private func handleTextField(_ sender: UITextField) {
        if sender == emailTextField {
            viewModel.emailText = sender.text
        }else if sender == passwordTextField {
            viewModel.passwordText = sender.text
        } else if sender == nameTextField {
            viewModel.nameText = sender.text
        }else {
            viewModel.usernameText = sender.text
        }
        registerButtonStatus()
    }
    @objc private func handleGoLogIn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
//MARK: - Helpers
extension RegisterViewController {
    private func registerButtonStatus() {
        if viewModel.status {
            registerButton.isEnabled = true
            registerButton.backgroundColor = #colorLiteral(red: 0.7717134953, green: 0.086325638, blue: 1, alpha: 1)
        }else {
            registerButton.isEnabled = true
            registerButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
  
    private func style() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        backgroundGradientColor()
        self.navigationController?.navigationBar.isHidden = true
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        //stackView style
        stackView = UIStackView(arrangedSubviews: [emailContainerView,nameContainerView,usernameContainerView, passwordContainerView, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //goLogInPage style
        goLogInPage.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        
    }
    
    private func layout() {
        view.addSubview(profileButton)
        view.addSubview(stackView)
        view.addSubview(goLogInPage)
        
        NSLayoutConstraint.activate([
            //profileButton layout
            profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileButton.widthAnchor.constraint(equalToConstant: 160),
            profileButton.heightAnchor.constraint(equalToConstant: 160),
            
            //stackView layout
            stackView.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 32),
            
            //goRegisterationPage layout
            goLogInPage.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            goLogInPage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            view.trailingAnchor.constraint(equalTo: goLogInPage.trailingAnchor, constant: 32),
        ])
        
    }
}
//MARK: - Picker
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        self.profileImage = image
        profileButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        profileButton.clipsToBounds = true
        profileButton.layer.cornerRadius = 160 / 2
        profileButton.contentMode = .scaleAspectFill
        profileButton.layer.borderColor = UIColor.white.cgColor
        profileButton.layer.borderWidth = 3
        self.dismiss(animated: true)
    }
}
