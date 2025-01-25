//
//  BirdsDto.swift
//  Birds
//
//  Created by Dylan on 24/01/2025.
//

import Foundation

struct BirdsDto: Decodable {
    enum CodingKeys: String, CodingKey {
        case birds = "Tbl_Bird"
    }
    let birds: [Bird]
}
