//
//  LoginViewController.swift
//  Messenger
//
//  Created by Sergey on 27.05.2022.
//

import UIKit

class LoginViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailField: UITextField = {
        let textFeild = UITextField()
        textFeild.autocapitalizationType = .none
        textFeild.autocorrectionType = .no
        textFeild.returnKeyType = .continue
        textFeild.layer.cornerRadius = 12
        textFeild.layer.borderWidth = 1
        textFeild.layer.borderColor = UIColor.lightGray.cgColor
        textFeild.placeholder = "Email adress . . ."
        textFeild.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textFeild.leftViewMode = .always
        textFeild.backgroundColor = .white
        return textFeild
    }()
    
    private let paswordField: UITextField = {
        let textFeild = UITextField()
        textFeild.autocapitalizationType = .none
        textFeild.autocorrectionType = .no
        textFeild.returnKeyType = .done
        textFeild.layer.cornerRadius = 12
        textFeild.layer.borderWidth = 1
        textFeild.layer.borderColor = UIColor.lightGray.cgColor
        textFeild.placeholder = "Password . . ."
        textFeild.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textFeild.leftViewMode = .always
        textFeild.backgroundColor = .white
        textFeild.isSecureTextEntry = true
        return textFeild
    }()
    
    private let loginButton: UIButton = {
       let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Log in"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        loginButton.addTarget(self,
                             action: #selector(loginButtonTapped),
                             for: .touchUpInside)
        
        emailField.delegate = self
        paswordField.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(paswordField)
        scrollView.addSubview(loginButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
        paswordField.frame = CGRect(x: 30,
                                    y: emailField.bottom+10,
                                    width: scrollView.width-60,
                                    height: 52)
        loginButton.frame = CGRect(x: 30,
                                  y: paswordField.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
    }
    
    @objc private func loginButtonTapped() {
        
        emailField.becomeFirstResponder()
        paswordField.becomeFirstResponder()
        
        guard let email = emailField.text, let password = paswordField.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6 else {
                  alertUserLoginError()
                  return }
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please inter all informationto log in",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismis",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            paswordField.becomeFirstResponder()
        }
        else if textField == paswordField {
            loginButtonTapped()
        }
        
        return true
    }
}
