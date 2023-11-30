//
//  Review.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 11/29/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Review: Codable {
    @DocumentID var uuid: String?
    @ServerTimestamp var timestamp: Date?
    let senderId: String
    let senderName: String
    let senderProfileImageURL: String
    let storeRating: Int
    let content: String
}
