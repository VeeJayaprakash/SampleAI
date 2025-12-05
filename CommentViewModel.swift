//
//  CommentViewModel.swift
//  SampleAI
//
//  Created by Vijendran  on 17/07/25.
//

import Combine
import Foundation

class CommentViewModel: ObservableObject {
    @Published var comments: [Comment] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    private var cancellable: AnyCancellable?

    func fetchComments(for postId: Int) {
        isLoading = true
        errorMessage = nil
        cancellable = APIService.shared.fetchComments(for: postId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                    self?.comments = []
                }
            }, receiveValue: { [weak self] comments in
                self?.comments = comments
            })
    }
}
