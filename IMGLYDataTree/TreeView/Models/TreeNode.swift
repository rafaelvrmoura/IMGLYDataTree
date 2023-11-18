//
//  TreeNode.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import Foundation

struct TreeNode: Decodable {

    let label: String?
    let id: String?
    let children: [TreeNode]?
}
