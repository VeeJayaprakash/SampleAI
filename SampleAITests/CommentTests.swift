//
//  CommentViewModelTests.swift
//  SampleAI
//
//  Created by Vijendran  on 17/07/25.
//

import XCTest
import Combine
import Foundation
import Testing

struct CommentTests {

    @Test
    func initializesWithAllProperties() {
        let comment = Comment(id: 1, postId: 2, name: "Test", email: "test@email.com", body: "Body text")
        #expect(comment.id == 1)
        #expect(comment.postId == 2)
        #expect(comment.name == "Test")
        #expect(comment.email == "test@email.com")
        #expect(comment.body == "Body text")
    }

    @Test
    func equalityWorksForIdenticalComments() {
        let c1 = Comment(id: 1, postId: 2, name: "A", email: "a@b.com", body: "Body")
        let c2 = Comment(id: 1, postId: 2, name: "A", email: "a@b.com", body: "Body")
        #expect(c1 == c2)
    }

    @Test
    func decodesFromValidJSON() throws {
        let json = """
        {
            "id": 10,
            "postId": 5,
            "name": "Jane",
            "email": "jane@doe.com",
            "body": "Hello"
        }
        """.data(using: .utf8)!
        let comment = try JSONDecoder().decode(Comment.self, from: json)
        #expect(comment.id == 10)
        #expect(comment.postId == 5)
        #expect(comment.name == "Jane")
        #expect(comment.email == "jane@doe.com")
        #expect(comment.body == "Hello")
    }

    @Test
    func decodingFailsWithMissingFields() {
        let json = """
        {
            "id": 1,
            "postId": 2,
            "name": "Test"
        }
        """.data(using: .utf8)!
        do {
            _ = try JSONDecoder().decode(Comment.self, from: json)
            #expect(false)
        } catch {
            #expect(true)
        }
    }
}
