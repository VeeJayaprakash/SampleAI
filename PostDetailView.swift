import SwiftUI

struct PostDetailView: View {
    let post: Post
    let user: User
    @StateObject private var commentVM = CommentViewModel()
    @State private var showComments = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(post.title)
                    .font(.title)
                    .bold()
                Text(post.body)
                    .font(.body)
                Divider()
                DisclosureGroup(
                    isExpanded: $showComments,
                    content: {
                        if commentVM.isLoading {
                            ProgressView("Loading Comments...")
                        } else {
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(commentVM.comments) { comment in
                                    Text(comment.body)
                                        .font(.body)
                                        .padding(.vertical, 4)
                                    Divider()
                                }
                            }
                        }
                    },
                    label: {
                        Text("Comments (\(commentVM.comments.count))")
                            .font(.headline)
                    }
                )
            }
            .padding()
        }
        .navigationTitle("\(user.name)'s Post")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            commentVM.fetchComments(for: post.id)
        }
    }
}
