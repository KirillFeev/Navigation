//
//  PostViewController.swift
//  Navigation
//
//  Created by Кирилл on 21.04.2022.
//

import UIKit

class PostViewController: UIViewController {

    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
//        title = post!.title
        makeBarButtonItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func layout() {
        
        let postView = PostView()
        postView.translatesAutoresizingMaskIntoConstraints = false
        postView.setupCell(PostData.post[post!.postIndex], indexPost: post!.postIndex)
        
        view.addSubview(postView)
        
        NSLayoutConstraint.activate([
            postView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    private func makeBarButtonItem() {
        let barButtonItem = UIBarButtonItem(title: "Открыть инфо", style: .plain, target: self, action: #selector(tapAction))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func tapAction() {
        let infoVc = InfoViewController()
        infoVc.title = "Инфо"
        present(infoVc, animated: true)
    }
}
