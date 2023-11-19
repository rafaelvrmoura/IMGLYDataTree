//
//  TreeViewModel.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import Foundation

@MainActor
class TreeViewModel: ObservableObject {

    unowned let service: ServiceLayerProtocol

    enum State {

        case loading
        case loaded(tree: [TreeNodeViewModel])
        case error(message: String)
        case empty
        case none
    }

    @Published private(set) var state: State

    init(with service: ServiceLayerProtocol) {

        self.service = service
        self.state = .none
    }

    func loadTree() async {
        
        self.state = .loading

        do {

            let tree = try await service.requestTree()

            self.state = .loaded(tree: tree.map { TreeNodeViewModel(node: $0, isExpanded: false) })

        } catch {
            
            self.state = .error(message: error.localizedDescription)
        }
    }

    func remove(_ offsets: IndexSet) {
        
        if case .loaded(let currentTree) = state {
            
            var mutableTree = currentTree
            mutableTree.remove(atOffsets: offsets)
            self.state = .loaded(tree: mutableTree)
        }
    }

    func move(childAt offsets: IndexSet, to destination: Int) {

        if case .loaded(let currentTree) = state {

            var mutableTree = currentTree
            mutableTree.move(fromOffsets: offsets, toOffset: destination)
            self.state = .loaded(tree: mutableTree)
        }
    }
}
