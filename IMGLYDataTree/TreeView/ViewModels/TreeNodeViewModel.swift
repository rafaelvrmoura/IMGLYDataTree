//
//  TreeNodeViewModel.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import Foundation

extension TreeNodeViewModel: Identifiable, Hashable {

    var id: String { node.id ?? UUID().uuidString }

    static func == (lhs: TreeNodeViewModel, rhs: TreeNodeViewModel) -> Bool {

        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class TreeNodeViewModel: ObservableObject {

    let node: TreeNode

    @Published var isExpanded: Bool
    @Published var children: [TreeNodeViewModel]?

    let label: String

    init(node: TreeNode, isExpanded: Bool) {

        self.node = node
        self.label = node.label ?? "[]"
        self.isExpanded = isExpanded
        self.children = node.children?.map { TreeNodeViewModel(node: $0, isExpanded: false) }
    }

    func removeChild(at index: Int) {

    }

    func insert(child: TreeNode, at index: Int) {
        
    }
}
