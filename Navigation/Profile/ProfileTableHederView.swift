//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Кирилл on 02.05.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private var topAvatarImageView = NSLayoutConstraint()
    private var leadingAvatarImageView = NSLayoutConstraint()
    private var widthAvatarImageView = NSLayoutConstraint()
    private var heightAvatarImageView = NSLayoutConstraint()
    
    private var constWidthAvatar: CGFloat = 110
    private var constHeightAvatar: CGFloat = 110
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "images")
        image.layer.borderWidth = 3.0
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = 110 / 2
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
        return image
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Morpheus Cat"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Waiting for something..."
        textField.textColor = .gray
        textField.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4
        button.titleLabel?.textColor = .white
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 40 / 2
        button.alpha = 0
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(closePressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    private func layout() {
        
        [fullNameLabel, statusTextField, setStatusButton, blackView, avatarImageView, closeButton].forEach { self.addSubview($0) }
        
        topAvatarImageView = avatarImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16)
        leadingAvatarImageView = avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        widthAvatarImageView = avatarImageView.widthAnchor.constraint(equalToConstant: constWidthAvatar)
        heightAvatarImageView = avatarImageView.heightAnchor.constraint(equalToConstant: constHeightAvatar)
        
        NSLayoutConstraint.activate([
            blackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            blackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            
            topAvatarImageView,
            leadingAvatarImageView,
            widthAvatarImageView,
            heightAvatarImageView,
            
            closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 2),
            closeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -2),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            
            fullNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16 + 110 + 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 50),
            statusTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16 + 110 + 16),
            statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 50),
            statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -34),
            setStatusButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16 + 110 + 16),
            setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonPressed() {
        let text = statusTextField.text!
        print(text)
    }
    
    @objc private func closePressed() {
        UIView.animate(withDuration: 0.3) {
            self.closeButton.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.topAvatarImageView.constant = 16
                self.leadingAvatarImageView.constant = 16
                self.widthAvatarImageView.constant = self.constWidthAvatar
                self.heightAvatarImageView.constant = self.constHeightAvatar
                self.avatarImageView.layer.cornerRadius = self.constHeightAvatar / 2
                self.blackView.isHidden = true
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc private func tapAction() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.isHidden = false
            let widthSafeArea = self.safeAreaLayoutGuide.layoutFrame.width
            let topConstant = (self.superview!.safeAreaLayoutGuide.layoutFrame.height / 2) - (widthSafeArea / 2)
            self.topAvatarImageView.constant = topConstant
            self.leadingAvatarImageView.constant = 0
            self.widthAvatarImageView.constant = widthSafeArea
            self.heightAvatarImageView.constant = widthSafeArea
            self.avatarImageView.layer.cornerRadius = 0
            self.layoutIfNeeded()
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeButton.alpha = 1
            }
        }
        
    }
    
}
