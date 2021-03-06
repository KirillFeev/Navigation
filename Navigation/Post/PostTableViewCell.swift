//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Кирилл on 14.05.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    private var likes = 0
    private var views = 0
    private var postIndex = 0
    var navigationController = UINavigationController()
    
    private lazy var postView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnImage)))
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        views = model.views
        postIndex = indexPost
    }
    
    private func customizeCell() {
        postView.layer.borderWidth = 2
    }
    
    private func layout() {
        
        let constIndent: CGFloat = 16
        
        [postView, authorLabel, postImageView, descriptionLabel, likesLabel, viewsLabel].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            postView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constIndent),
            postView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            authorLabel.topAnchor.constraint(equalTo: postView.topAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: constIndent),
            authorLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor),
            authorLabel.heightAnchor.constraint(equalToConstant: 50),
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: constIndent),
            postImageView.leadingAnchor.constraint(equalTo: postView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: postView.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: constIndent),
            descriptionLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: constIndent),
            descriptionLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -constIndent),
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: constIndent),
            likesLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: constIndent),
            likesLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor),
            likesLabel.heightAnchor.constraint(equalToConstant: 50),
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: constIndent),
            viewsLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -constIndent),
            viewsLabel.heightAnchor.constraint(equalToConstant: 50),
            viewsLabel.bottomAnchor.constraint(equalTo: postView.bottomAnchor)
        ])
        
    }
    
    @objc private func tapOnLike() {
        likes += 1
        likesLabel.text = "Likes: \(String(likes))"
        PostData.post[postIndex].likes = likes
    }
    
    @objc private func tapOnImage() {
        views += 1
        viewsLabel.text = "Views: \(String(views))"
        PostData.post[postIndex].views = views
        let postDetail = PostViewController()
        postDetail.post = Post(title: "Это пост", postIndex: postIndex)
        navigationController.pushViewController(postDetail, animated: true)
    }
    
}
