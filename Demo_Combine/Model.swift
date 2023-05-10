//
//  Model.swift
//  Demo_Combine
//
//  Created by Azad Rather on 10/05/23.
//

import Foundation

struct Post: Codable {
    let id: Int
    let title: String
    let body: String?
    var completed: Bool?
    let userId: Int
}
