//
//  UsersPostsView.swift
//  SampleAI
//
//  Created by Vijendran  on 17/07/25.
//

import SwiftUI

struct UserPostsView: View {
    let user: User
    @StateObject private var viewModel = PostViewModel()

    var body: some View {
        List(viewModel.posts) { post in
            NavigationLink(destination: PostDetailView(post: post, user: user)) {
                Text(post.title)
                    .font(.headline)
            }
        }
        .navigationTitle("\(user.name)'s Posts")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchPosts(for: user.id)
        }
    }
}
