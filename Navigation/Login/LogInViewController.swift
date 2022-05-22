//
//  LogInViewController.swift
//  Navigation
//
//  Created by Кирилл on 11.05.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    private let nc = NotificationCenter.default
    private let minNumberChar = 6
    private let standartUserName = "Vasya"
    private let standartPassword = "qwerty"
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Email of phone"
        textField.textColor = .black
        textField.font = UIFont(name: "normal", size: 16.0)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Password"
        textField.textColor = .black
        textField.font = UIFont(name: "normal", size: 16.0)
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        textField.addTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var passwordWarningLabel: UILabel = {
        let label = UILabel()
        label.text = "password is too short - must be at least \(minNumberChar) characters"
        label.isHidden = true
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.layer.cornerRadius = 10
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func kbdShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kbdSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
        }
    }
    
    @objc private func kbdHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    @objc private func buttonPressed() {
        let profileVc = ProfileViewController()
        let loginIsEmpty = checkLogin()
        let passwordIsEmpty = checkPassword(loginIsEmpty)
        
        if loginIsEmpty && passwordIsEmpty {
            let loginPasswordIsStandart = checkStandartLogoPass()
            if loginPasswordIsStandart {
            navigationController?.pushViewController(profileVc, animated: true)
            } else {
                makeAlert()
            }
        }
    }
    
    @objc private func editingChanged(sender: UITextField) {
        
        if let text = sender.text, text.count < minNumberChar && text.count > 0 {
            passwordWarningLabel.isHidden = false
        } else {
            passwordWarningLabel.isHidden = true
        }
    }
    
    private func checkLogin() -> Bool {
     
        if emailTextField.text!.isEmpty {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.3,
                           initialSpringVelocity: 0.2,
                           options: .curveEaseInOut) {
                self.emailTextField.layer.borderColor = UIColor.darkGray.cgColor
                self.emailTextField.layer.borderWidth = 4
            } completion: { _ in
                UIView.animate(withDuration: 0.5) {
                    self.emailTextField.layer.borderColor = UIColor.lightGray.cgColor
                    self.emailTextField.layer.borderWidth = 0.5
                }
            }
            return false
        } else {
            return true
        }
    }
    
    private func checkPassword(_ loginIsEmpty: Bool) -> Bool {
        var delay = 0.5
        if loginIsEmpty {
            delay = 0
        }
        if passwordTextField.text!.isEmpty {
            UIView.animate(withDuration: 0.5,
                           delay: delay,
                           usingSpringWithDamping: 0.3,
                           initialSpringVelocity: 0.2,
                           options: .curveEaseInOut) {
                self.passwordTextField.layer.borderColor = UIColor.darkGray.cgColor
                self.passwordTextField.layer.borderWidth = 4
            } completion: { _ in
                UIView.animate(withDuration: 0.5) {
                    self.passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
                    self.passwordTextField.layer.borderWidth = 0.5
                }
            }
            return false
        } else {
            return true
        }
    }
    
    private func checkStandartLogoPass() -> Bool {
        
        if emailTextField.text! == standartUserName && passwordTextField.text! == standartPassword {
            return true
        } else {
            return false
        }
    }
    
    private func makeAlert() {
        let message = "Please check your login and password"
        let alert = UIAlertController(title: "Authentication failed", message: message, preferredStyle: .actionSheet)
        let doneAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(doneAction)
        present(alert, animated: true)
    }
    
    private func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    private func layout() {
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        [logoImageView, emailTextField, passwordTextField, passwordWarningLabel, loginButton].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordWarningLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 4),
            passwordWarningLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            passwordWarningLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            passwordWarningLabel.heightAnchor.constraint(equalToConstant: 20),
            
            loginButton.topAnchor.constraint(equalTo: passwordWarningLabel.bottomAnchor, constant: 10),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
