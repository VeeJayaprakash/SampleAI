//
//  Post.swift
//  SampleAI
//
//  Created by Vijendran  on 17/07/25.
//

import Foundation
                            
struct Post: Identifiable, Decodable {
    let id: Int
    let title: String
    let body: String  
}
