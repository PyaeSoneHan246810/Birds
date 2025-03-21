//
//  FileDecodingError.swift
//  Birds
//
//  Created by Dylan on 24/01/2025.
//

import Foundation

enum FileDecodingError: LocalizedError {
    case fileNotFound
    case invalidData
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "File to decode was not found."
        case .invalidData:
            return "Data to decode was invalid."
        case .decodingFailed:
            return "Decoding was failed."
        }
    }
}
