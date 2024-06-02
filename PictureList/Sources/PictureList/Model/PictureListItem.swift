//
//  PictureListItem.swift
//
//
//  Created by Mayank Gandhi on 01/06/24.
//

import Foundation

struct PictureListItem: Equatable, Identifiable, Codable {
    var id: UUID = UUID()
    
    let date, explanation: String
    let hdurl: URL?
    let mediaType, serviceVersion, title: String
    let url: URL
    let copyright: String?
}
