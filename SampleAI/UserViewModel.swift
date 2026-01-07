//
//  UserViewModel.swift
//  SampleAI
//
//  Created by Vijendran  on 17/07/25.
//

import Combine
import Foundation

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    private var cancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()

    func fetchUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [User].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.users, on: self)
            .store(in: &cancellables)
    }
}



