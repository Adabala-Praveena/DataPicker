//
//  InputData.swift
//  Assignment
//
//  Created by Praveena on 01/05/24.
//

import Foundation

/// A struct representing a InputData with its properties.
struct InputData: Codable, Identifiable {
    /// The unique identifier of the InputData.
    let id: Int
    /// The title of the InputData.
    let title: String
    /// The body content of the InputData.
    let body: String
}
