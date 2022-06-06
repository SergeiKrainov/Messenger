//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Sergey on 27.05.2022.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let firstNameField: UITextField = {
        let textFeild = UITextField()
        textFeild.autocapitalizationType = .none
        textFeild.autocorrectionType = .no
        textFeild.returnKeyType = .continue
        textFeild.layer.cornerRadius = 12
        textFeild.layer.borderWidth = 1
        textFeild.layer.borderColor = UIColor.lightGray.cgColor
        textFeild.placeholder = "First name . . ."
        textFeild.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textFeild.leftViewMode = .always
        textFeild.backgroundColor = .white
        return textFeild
    }()
    
    private let lastNameField: UITextField = {
        let textFeild = UITextField()
        textFeild.autocapitalizationType = .none
        textFeild.autocorrectionType = .no
        textFeild.returnKeyType = .continue
        textFeild.layer.cornerRadius = 12
        textFeild.layer.borderWidth = 1
        textFeild.layer.borderColor = UIColor.lightGray.cgColor
        textFeild.placeholder = "Last name . . ."
        textFeild.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textFeild.leftViewMode = .always
        textFeild.backgroundColor = .white
        return textFeild
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Register"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        registerButton.addTarget(self,
                             action: #selector(registerButtonTapped),
                             for: .touchUpInside)
        
        emailField.delegate = self
        paswordField.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(paswordField)
        scrollView.addSubview(registerButton)
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self,
                                          action: #selector(didTapChangeProfilePic))
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapChangeProfilePic() {
        print("Change pic called")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        firstNameField.frame = CGRect(x: 30,
                                  y: imageView.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
        lastNameField.frame = CGRect(x: 30,
                                  y: firstNameField.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
        emailField.frame = CGRect(x: 30,
                                  y: lastNameField.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
        paswordField.frame = CGRect(x: 30,
                                    y: emailField.bottom+10,
                                    width: scrollView.width-60,
                                    height: 52)
        registerButton.frame = CGRect(x: 30,
                                  y: paswordField.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
    }
    
    @objc private func registerButtonTapped() {
        
        emailField.becomeFirstResponder()
        paswordField.becomeFirstResponder()
        firstNameField.becomeFirstResponder()
        lastNameField.becomeFirstResponder()
        
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = paswordField.text,
              !email.isEmpty,
              !password.isEmpty,
              !firstName.isEmpty,
              !lastName.isEmpty,
              password.count >= 6 else {
                  alertUserLoginError()
                  return }
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please inter all information to create a new account",
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

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            paswordField.becomeFirstResponder()
        }
        else if textField == paswordField {
            registerButtonTapped()
        }
        
        return true
    }
}
