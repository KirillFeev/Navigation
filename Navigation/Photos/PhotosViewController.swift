//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Кирилл on 17.05.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private let photosModel = PhotosModel.makeModel()
    private var topPhotoImageView = NSLayoutConstraint()
    private var leadingPhotoImageView = NSLayoutConstraint()
    private var widthPhotoImageView = NSLayoutConstraint()
    private var heightPhotoImageView = NSLayoutConstraint()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Gallery"
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func closePressed() {
        UIView.animate(withDuration: 0.3) {
            self.closeButton.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.photoImageView.isHidden = true
                self.blackView.isHidden = true
            }
        }
    }
    
    private func layout() {
        
        [collectionView, blackView, photoImageView, closeButton].forEach { view.addSubview($0) }
        
        topPhotoImageView = photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        leadingPhotoImageView = photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        widthPhotoImageView = photoImageView.widthAnchor.constraint(equalToConstant: 110)
        heightPhotoImageView = photoImageView.heightAnchor.constraint(equalToConstant: 110)
        
        NSLayoutConstraint.activate([
            blackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            blackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            topPhotoImageView,
            leadingPhotoImageView,
            widthPhotoImageView,
            heightPhotoImageView,
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -2),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        if photosModel.count >= indexPath.row {
            cell.setupCell(photosModel[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imageName = "photo_\(indexPath.item + 1)"
        
        UIView.animate(withDuration: 0.5) {
            self.photoImageView.isHidden = false
            self.blackView.isHidden = false
            self.photoImageView.image = UIImage(named: imageName)
            let widthSafeArea = self.view.safeAreaLayoutGuide.layoutFrame.width
            let topConstant = (self.view.safeAreaLayoutGuide.layoutFrame.height / 2) - (widthSafeArea / 2)
            self.topPhotoImageView.constant = topConstant
            self.widthPhotoImageView.constant = widthSafeArea
            self.heightPhotoImageView.constant = widthSafeArea
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeButton.alpha = 1
            }
        }
    }
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * 4) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
}
