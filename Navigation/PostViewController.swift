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
        view.backgroundColor = .blue
        title = post!.title
        makeBarButtonItem()
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
