//
//  EntryDetailsView.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import SwiftUI

struct EntryDetailsView: View {

    @StateObject private var viewModel: EntryDetailsViewModel

    let entryId: String
    let label: String

    init(with service: ServiceLayerProtocol,
         entryId: String,
         label: String) {

        self.entryId = entryId
        self.label = label
        _viewModel = StateObject(wrappedValue: EntryDetailsViewModel(with: service))
    }

    var body: some View {

        switch viewModel.state {
            
        case .loading:
            ProgressView().onAppear {
                
                Task {
                    
                    await viewModel.loadDetails(forEntryWith: entryId)
                }
            }
            
        case.loaded(let details):
            List(details) { info in
                VStack(alignment: .leading, spacing: 8) {
                    Text(info.title).fontWeight(.bold)
                    Text(info.description)
                }
            }
            .navigationTitle(label)

        case .error(let message):
            ErrorStateView(errorMessage: message)
            
        case .empty:
            EmptyStateView()
        }
    }
}

#Preview {
    EntryDetailsView(with: ServiceLayerMock.instance,
                     entryId: "",
                     label: "Entry")
}
