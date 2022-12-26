//  User.swift
//  RestApiApp
//  Created by Carolina on 27.12.22.

import Foundation

/// 1) подписываемся под Codable
/// 2) если вы предпологаете что данные могут не прийти делаем опцтонал "?"
/// 3) имена свойств точно совпадают с именами параметров

struct User: Codable {
    let id: Int
    let name: String?
    let username: String?
    let email: String?
    let phone: String?
    let website: String?
    let address: Address?
    let company: Company?
}
