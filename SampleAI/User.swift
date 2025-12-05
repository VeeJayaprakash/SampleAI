//
//  User.swift
//  SampleAI
//
//  Created by Vijendran  on 17/07/25.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: Int
    let name: String
    let email: String
}
