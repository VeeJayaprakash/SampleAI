//
//  PostViewModel.swift
//  SampleAI
//
//  Created by Vijendran  on 17/07/25.
//

import Combine
import Foundation

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading: Bool = false
    private var cancellable: AnyCancellable?

    func fetchPosts(for userId: Int) {
        isLoading = true
        let minDisplayTime = 0.5
        let start = Date()
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userId)") else { return }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] posts in
                let elapsed = Date().timeIntervalSince(start)
                let delay = max(0, minDisplayTime - elapsed)
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self?.posts = posts
                    self?.isLoading = false
                }
            }
    }
}

