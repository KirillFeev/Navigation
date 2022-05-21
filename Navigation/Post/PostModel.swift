//
//  PostModel.swift
//  Navigation
//
//  Created by Кирилл on 14.05.2022.
//

import UIKit

struct PostModel {
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
    
    static func makeModel() -> [PostModel] {
        var post = [PostModel]()
        
        post.append(PostModel(author: "Москвичка решила запатентовать мем про Наташу и котов", description: "Москвичка подала заявку в Роспатент на регистрацию фразы из популярного мема про Наташу и котов в качестве товарного знака, сообщает Агентство городских новостей «Москва» со ссылкой на документацию.", image: "natasha&cats", likes: 450, views: 500))
        
        post.append(PostModel(author: "Слюнявчик добрался до Челябинска", description: "Жителям Челябинска так понравился кот, что они нанесли его изображение на трансформаторный шкаф, расположенный на столбе.", image: "cherry_cat", likes: 100, views: 200))
        
        post.append(PostModel(author: "Художник из Индонезии перерисовывает мемы с котами", description: "Сейчас интернет до краёв заполнен фотографиями котиков всех цветов и размеров, некоторые из которых тут же превращаются в мемы. Чтобы сделать эти снимки ещё лучше, художник из Индонезии по имени Кинг Роки создаёт их рисованные версии.", image: "octocat", likes: 250, views: 340))
        
        post.append(PostModel(author: "Иллюстратор превращает мемы с котами в забавные рисунки", description: "Давайте же посмотрим на новые смешные и вирусные мемы с питомцами, взятые из жизни!", image: "lizard&cat", likes: 200, views: 400))
        
        return post
    }
}
