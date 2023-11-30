//
//  ViewController.swift
//  ToDoApp
//
//  Created by Caner Karabulut on 15.09.2023.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: - Properties
    private var viewModel = LogInViewModel()
    
    private let logoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "checkmark.diamond")
        imageView.tintColor = .white
        return imageView
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
        return textField
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.layer.cornerRadius = 7
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()
    
    
    private var stackView = UIStackView()
    
    private lazy var goRegisterationPage: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Click To Become A Member", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleGoRegister), for: .touchUpInside)
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
extension LoginViewController{
    @objc private func handleLoginButton(_ sender: UIButton) {
        guard let emailText = emailTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        showHud(show: true)
        AuthService.login(emailText: emailText, passwordText: passwordText) { result, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                self.showHud(show: false)
                return
            }
            self.showHud(show: false)
            self.dismiss(animated: true)
        }
    }
    
    @objc private func handleGoRegister(_ sender: UIButton) {
        let controller = RegisterViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @objc private func handleTextField(_ sender: UITextField) {
        if sender == emailTextField {
            viewModel.emailText = sender.text
        }else {
            viewModel.passwordText = sender.text
        }
        logInButtonStatus()
    }
}

//MARK: - Helpers
extension LoginViewController{
    
    private func logInButtonStatus() {
        if viewModel.status {
            logInButton.isEnabled = true
            logInButton.backgroundColor = #colorLiteral(red: 0.7717134953, green: 0.086325638, blue: 1, alpha: 1)
        }else {
            logInButton.isEnabled = true
            logInButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    
    private func style() {
        backgroundGradientColor()
        
        //logoImageView style
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.layer.cornerRadius = 150 / 2
        //stackView style
        stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, logInButton])
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //goRegisterationPage style
        goRegisterationPage.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        

    }
    
    private func layout() {
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        view.addSubview(goRegisterationPage)
        
        NSLayoutConstraint.activate([
            //logoImageView layout
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 160),
            logoImageView.heightAnchor.constraint(equalToConstant: 160),
            //stackView layout
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 32),
            //goRegisterationPage layout
            goRegisterationPage.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            goRegisterationPage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            view.trailingAnchor.constraint(equalTo: goRegisterationPage.trailingAnchor, constant: 32),
            
        ])
        
    }
    
}

