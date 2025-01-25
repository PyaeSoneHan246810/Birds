//
//  Image+Extensions.swift
//  Birds
//
//  Created by Dylan on 24/01/2025.
//

import SwiftUI

extension Image {
    init?(_ fileName: String) {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: nil) else {
            return nil
        }
        guard let uiImage = UIImage(contentsOfFile: filePath) else {
            return nil
        }
        self.init(uiImage: uiImage)
    }
}
