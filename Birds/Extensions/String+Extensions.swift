//
//  String+Extensions.swift
//  Birds
//
//  Created by Dylan on 24/01/2025.
//

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
