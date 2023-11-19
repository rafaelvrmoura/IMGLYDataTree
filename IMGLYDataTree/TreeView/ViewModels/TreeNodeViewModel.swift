//
//  TreeNodeViewModel.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import Foundation

extension TreeNodeViewModel: Identifiable, Hashable {

    static func == (lhs: TreeNodeViewModel, rhs: TreeNodeViewModel) -> Bool {

        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class TreeNodeViewModel: ObservableObject {

    private var node: TreeNode

    @Published var isExpanded: Bool
    @Published var children: [TreeNodeViewModel]?
    let id: String

    let label: String

    init(node: TreeNode, isExpanded: Bool) {

        self.node = node
        self.id = node.id ?? UUID().uuidString
        self.label = node.label ?? "-"
        self.isExpanded = isExpanded
        self.children = node.children?.map { TreeNodeViewModel(node: $0, isExpanded: false) }
    }

    func removeChild(at offsets: IndexSet) {

        node.children?.remove(atOffsets: offsets)
        children?.remove(atOffsets: offsets)
    }

    func move(childAt offsets: IndexSet, to destination: Int) {
        
        node.children?.move(fromOffsets: offsets, toOffset: destination)
        children?.move(fromOffsets: offsets, toOffset: destination)
    }
}
