//
//  PostView.swift
//  Navigation
//
//  Created by Кирилл on 22.05.2022.
//

import UIKit

class PostView: UIView {

    private var likes = 0
    private var postIndex = 0
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnLike)))
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ model: PostModel, indexPost: Int) {
        postImageView.image = UIImage(named: model.image)
        authorLabel.text = model.author
        descriptionLabel.text = model.description
        likesLabel.text = "Likes: \(String(model.likes))"
        viewsLabel.text = "Views: \(String(model.views))"
        likes = model.likes
        postIndex = indexPost
    }
    
    private func layout() {
        
        let constIndent: CGFloat = 16
        
        [authorLabel, postImageView, descriptionLabel, likesLabel, viewsLabel].forEach { self.addSubview($0) }
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: self.topAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constIndent),
            authorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            authorLabel.heightAnchor.constraint(equalToConstant: 50),
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: constIndent),
            postImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2),
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: constIndent),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constIndent),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -constIndent),
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: constIndent),
            likesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constIndent),
            likesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            likesLabel.heightAnchor.constraint(equalToConstant: 50),
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: constIndent),
            viewsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -constIndent),
            viewsLabel.heightAnchor.constraint(equalToConstant: 50),
            viewsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    @objc private func tapOnLike() {
        likes += 1
        likesLabel.text = "Likes: \(String(likes))"
        PostData.post[postIndex].likes = likes
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("ChangedPostData"), object: nil)
    }

}
