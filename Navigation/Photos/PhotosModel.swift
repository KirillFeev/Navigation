//
//  PhotosModel.swift
//  Navigation
//
//  Created by Кирилл on 17.05.2022.
//

import UIKit

struct PhotosModel {

    let imageName: String
    
    static func makeModel() -> [PhotosModel] {
        var photos = [PhotosModel]()
        let count = 1...20
        
        for number in count {
        photos.append(PhotosModel(imageName: "photo_\(number)"))
        }
        
        return photos
    }
}
