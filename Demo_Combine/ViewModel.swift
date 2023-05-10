//
//  ViewModel.swift
//  Demo_Combine
//
//  Created by Azad Rather on 03/05/23.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    @Published var details: [Post]?
    
    func getPosts(){
        
        NetworkManager.shared.getData(endpoint: .posts, id: nil,type: Post.self)
            .sink { _ in
            } receiveValue: { [weak self] posts in
                self?.details = posts
            }
            .store(in: &cancellables)
    }
    
    func getPosts1() -> Future<[Post], Error>{
        return Future<[Post], Error> { [weak self] promise in
            guard let self = self else{return}
                    NetworkManager.shared.getData(endpoint: .posts, id: nil,type: Post.self)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        dump("Failed to load data")
                    }
                }, receiveValue: { promise(.success($0)) })
                    .store(in: &self.cancellables)
        }
    }
    
}
