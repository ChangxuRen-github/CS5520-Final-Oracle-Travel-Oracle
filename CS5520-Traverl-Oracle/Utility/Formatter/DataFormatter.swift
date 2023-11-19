//
//  DataFormatter.swift
//  CS5520-Traverl-Oracle
//
//  Created by dongjun xie on 11/18/23.
//

import Foundation

class DateFormatter {
    static func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "Unknown" }

        let formatter = Foundation.DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
