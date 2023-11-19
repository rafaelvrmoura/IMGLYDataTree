//
//  TreeNodeView.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import SwiftUI

struct TreeNodeView: View {

    @ObservedObject var viewModel: TreeNodeViewModel

    var body: some View {

        if let children = viewModel.children,
           children.isEmpty == false {

            DisclosureGroup(isExpanded: $viewModel.isExpanded) {

                ForEach(children) { child in

                    TreeNodeView(viewModel: child)

                }.onDelete { offsets in
                    viewModel.removeChild(at: offsets)

                }.onMove { sourceOffsets, destination in
                    viewModel.move(childAt: sourceOffsets, to: destination)
                }

            } label: {

                Text(viewModel.label)
            }

        } else {

            NavigationLink(viewModel.label, value: viewModel)
        }
    }
}
