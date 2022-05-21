//
//  InfoViewController.swift
//  Navigation
//
//  Created by Кирилл on 21.04.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeButton()
    }
    
    private func makeButton() {
     let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.center = view.center
        button.setTitle("Показать инфо", for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func tapAction() {
        let alert = UIAlertController(title: "Информация о приложении", message: "Версия 1.0", preferredStyle: .actionSheet)
        let doneAction = UIAlertAction(title: "Закрыть", style: .default, handler: {_ in print("Нажата кнопка закрыть")})
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: {_ in print("Нажата кнопка отмена")})
        alert.addAction(doneAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

}
