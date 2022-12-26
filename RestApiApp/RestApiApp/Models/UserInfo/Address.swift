//  Address.swift
//  RestApiApp
//  Created by Carolina on 27.12.22.

import Foundation

struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
}
