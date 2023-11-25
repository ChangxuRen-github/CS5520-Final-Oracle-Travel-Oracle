//
//  MessageDAO.swift
//  CS5520-Traverl-Oracle
//
//  Created by Changxu Ren on 11/24/23.
//

import Foundation
import FirebaseFirestoreSwift

struct MessageDAO: Codable {
    @DocumentID var uuid: String?
    @ServerTimestamp var timestamp: Date?
    let senderId: String
    let senderName: String
    let content: String
    // this is used to indicate the current message is an image
    var isImage: Bool = false
    var imageURL: String?
}
