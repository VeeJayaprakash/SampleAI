//
//  Comment.swift
//  SampleAI
//
//  Created by Vijendran  on 17/07/25.
//

import Foundation

struct Comment: Identifiable, Decodable, Equatable {
    let id: Int
    let postId: Int?
    let name: String
    let email: String
    let body: String
}
