//
//  APIService.swift
//  SampleAI
//
//  Created by Vijendran  on 17/07/25.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    //func fetchPosts(for userId: Int) -> AnyPublisher<[Post], Error>
    func fetchComments(for postId: Int) -> AnyPublisher<[Comment], Error>
    //func fetchUsers() -> AnyPublisher<[User], Error>
}

class APIService {
    static let shared = APIService()
    private init() {}

    func fetchPosts(for userId: Int) -> AnyPublisher<[Post], Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userId)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchComments(for postId: Int) -> AnyPublisher<[Comment], Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(postId)/comments") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Comment].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchUsers() -> AnyPublisher<[User], Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [User].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
