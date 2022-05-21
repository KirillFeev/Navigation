//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Кирилл on 16.05.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private let photosModel = PhotosModel.makeModel()
    
    private lazy var horizontalStackView: UIStackView = {
        let mStackView = UIStackView()
        
        mStackView.axis  = .horizontal
        mStackView.distribution  = .fillEqually
        mStackView.alignment = .center
        mStackView.spacing = 8
        mStackView.translatesAutoresizingMaskIntoConstraints = false
        mStackView.backgroundColor = .white
        
        return mStackView
    }()
    
    private lazy var photosView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.forward")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var photosImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: photosModel[0].imageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var photosImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: photosModel[1].imageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var photosImageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: photosModel[2].imageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var photosImageView4: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: photosModel[3].imageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        
        [photosImageView1, photosImageView2, photosImageView3, photosImageView4].forEach { horizontalStackView.addArrangedSubview($0) }
        
        [photosView, titleLabel, arrowImageView, horizontalStackView].forEach { contentView.addSubview($0) }
        
        arrowImageView.center.y = titleLabel.center.y
        
        NSLayoutConstraint.activate([
            photosView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photosView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photosView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photosView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            arrowImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowImageView.heightAnchor.constraint(equalToConstant: 30),
            arrowImageView.widthAnchor.constraint(equalToConstant: 30),
            horizontalStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
}
