//
//  Bird.swift
//  Birds
//
//  Created by Dylan on 24/01/2025.
//

import Foundation

struct Bird: Identifiable, Decodable, Hashable {
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case myanmarName = "BirdMyanmarName"
        case englishName = "BirdEnglishName"
        case description = "Description"
        case imagePath = "ImagePath"
    }
    
    let id: Int
    let myanmarName: String
    let englishName: String
    let description: String
    let imagePath: String
    
    var trimmedDescription: String {
        description.trimmingCharacters(in: .newlines)
    }
    var imageFileName: String {
        imagePath.replacingOccurrences(of: "img/", with: "")
    }
}
