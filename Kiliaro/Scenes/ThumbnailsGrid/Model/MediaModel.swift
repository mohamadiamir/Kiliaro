//
//  MEDIA.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/27/22.
//

import Foundation

struct MediaModel: Codable{
    let id: String?
    let userID: String?
    let mediaType: MediaType?
    let filename: String?
    let size: Int?
    let createdAt: String?
    let thumbnailURL, downloadURL: String?

    enum CodingKeys: String, CodingKey {
        case id, filename, size
        case userID = "user_id"
        case mediaType = "media_type"
        case createdAt = "created_at"
        case thumbnailURL = "thumbnail_url"
        case downloadURL = "download_url"
    }
}


enum MediaType: String, Codable {
    case image = "image"
}
