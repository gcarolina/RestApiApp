//  Post.swift
//  RestApiApp
//  Created by Carolina on 27.12.22.

import Foundation

struct Post: Decodable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}
