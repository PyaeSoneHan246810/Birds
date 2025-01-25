//
//  Bundle+Extensions.swift
//  Birds
//
//  Created by Dylan on 24/01/2025.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ jsonFileName: String) throws -> T {
        guard let fileUrl = Bundle.main.url(forResource: jsonFileName, withExtension: ".json") else {
            throw FileDecodingError.fileNotFound
        }
        guard let data = try? Data(contentsOf: fileUrl) else {
            throw FileDecodingError.invalidData
        }
        guard let decodedObject = try? JSONDecoder().decode(T.self, from: data) else {
            throw FileDecodingError.decodingFailed
        }
        return decodedObject
    }
}
