//
//  TreeView.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import SwiftUI
import SwiftData

struct TreeView: View {

    @StateObject private var viewModel: TreeViewModel
    @State private var navigationPath = NavigationPath()

    private unowned let service: ServiceLayerProtocol

    init(service: ServiceLayerProtocol) {

        self.service = service
        _viewModel = StateObject(wrappedValue: TreeViewModel(with: service))
    }

    var body: some View {

        NavigationStack(path: $navigationPath) {

            switch viewModel.state {

            case .loading:
                ProgressView()

            case .loaded(let nodes):
                List {
                    ForEach(nodes) { node in
                        TreeNodeView(viewModel: node)
                    }
                    .onDelete { indexSet in
                        // TODO: call delete on viewModel

                    }
                    .onMove { indices, newOffset in
                        // TODO: call move on viewModel
                    }
                }
                .refreshable {
                    loadTree()
                }
                .navigationTitle("IMGLY Tree")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                }
                .navigationDestination(for: TreeNodeViewModel.self) { node in

                    EntryDetailsView(with: service,
                                     entryId: node.id,
                                     label: node.label)
                }

            case .error(let message):
                ErrorStateView(errorMessage: message)

            case .empty,
                 .none:
                EmptyStateView()
            }

        }.onAppear {
            
            loadTree()
        }
    }

    private func loadTree() {

        Task {

            await viewModel.loadTree()
        }
    }
}

#Preview {
    TreeView(service: ServiceLayerMock.instance)
}
