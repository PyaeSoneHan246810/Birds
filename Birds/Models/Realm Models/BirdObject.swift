//
//  BirdObject.swift
//  Birds
//
//  Created by Dylan on 24/01/2025.
//

import SwiftUI
import RealmSwift

class BirdObject: Object, Identifiable {
    @Persisted(primaryKey: true) var birdId: Int
    @Persisted var myanmarName: String
    @Persisted var englishName: String
    @Persisted var desc: String
    @Persisted var imageFileName: String
    
    override class func primaryKey() -> String? {
        return "birdId"
    }
}
