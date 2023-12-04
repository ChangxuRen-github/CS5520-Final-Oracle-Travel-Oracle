//
//  Store.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 11/24/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Store: Codable {
    let id: String
    @ServerTimestamp var createdAt: Date?
    // saves the uid for the user who created the store
    let createdBy: String
    // store name
    let displayName: String
    let description: String
    // saves price in dollar sign. e.g., $, $$...
    let price: String
    // save store's category
    let category: String
    // saves images url
    var images: [String]
    // saves filters
    let tag: Tag
    let location: String
}
