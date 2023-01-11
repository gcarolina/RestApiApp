//  Comment.swift
//  RestApiApp
//  Created by Carolina on 27.12.22.

import Foundation

struct Comment: Decodable {
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
}
