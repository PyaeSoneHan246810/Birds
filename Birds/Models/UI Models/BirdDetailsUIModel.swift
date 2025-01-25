//
//  BirdDetailsUIModel.swift
//  Birds
//
//  Created by Dylan on 25/01/2025.
//

import Foundation

struct BirdDetailsUIModel {
    let id: Int
    let myanmarName: String
    let englishName: String
    let description: String
    let imageFileName: String
    
    init(id: Int, myanmarName: String, englishName: String, description: String, imageFileName: String) {
        self.id = id
        self.myanmarName = myanmarName
        self.englishName = englishName
        self.description = description
        self.imageFileName = imageFileName
    }
    
    init(bird: Bird) {
        self.init(
            id: bird.id,
            myanmarName: bird.myanmarName,
            englishName: bird.englishName,
            description: bird.trimmedDescription,
            imageFileName: bird.imageFileName
        )
    }
    
    init(birdObject: BirdObject) {
        self.init(
            id: birdObject.birdId,
            myanmarName: birdObject.myanmarName,
            englishName: birdObject.englishName,
            description: birdObject.desc,
            imageFileName: birdObject.imageFileName
        )
    }
}
