# Combine_With_Swift
Sample example to demonstrate how to use combine to handle data from api's and passing data from viewmodel to view
in your view model you can call your api like this
 NetworkManager.shared.getData(endpoint: .posts, id: nil,type: Post.self)
            .sink { _ in
            } receiveValue: { [weak self] posts in
                self?.details = posts
            }
            .store(in: &cancellables)
