//  Photo.swift
//  RestApiApp
//  Created by Carolina on 27.12.22.

import Foundation

struct Photo: Decodable {
    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}
