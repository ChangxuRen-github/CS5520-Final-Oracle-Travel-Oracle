//
//  Conversation.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 11/24/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Conversation: Codable {
    @DocumentID var uuid: String?
    @ServerTimestamp var createdAt: Date?
    let createdBy: String
    let participantIds: [String]
    var lastMessageTimestamp: Date?
    var lastMessageText: String?
}
