//
//  JournalEntry.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

import Foundation

struct JournalEntry: Identifiable, Equatable {
    let id: UUID
    let tripId: UUID
    let date: Date
    let text: String
    let photoURLs: [URL]
}
