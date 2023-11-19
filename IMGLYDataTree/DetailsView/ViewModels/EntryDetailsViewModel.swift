//
//  EntryDetailsViewModel.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import Foundation

@MainActor
class EntryDetailsViewModel: ObservableObject {

    enum State {

        case loading
        case loaded(details: [EntryDetailInfo])
        case error(message: String)
        case empty
    }

    struct EntryDetailInfo: Identifiable {

        let title: String
        let description: String
        let id = UUID()
    }

    unowned let service: ServiceLayerProtocol

    @Published var state: State

    init(with service: ServiceLayerProtocol) {

        self.state = .loading
        self.service = service
    }

    func loadDetails(forEntryWith id: String) async {

        do {

            let detail = try await service.requestEntryDetails(id: id)
            self.state = .loaded(details: detailsIfo(with: detail))

        } catch {

            self.state = .error(message: error.localizedDescription)
        }
    }

    private func detailsIfo(with detail: EntryDetail) -> [EntryDetailInfo] {

        var details: [EntryDetailInfo] = []

        if let id = detail.id {

            details.append(EntryDetailInfo(title: "Id", description: id))
        }

        if let createdAt = detail.createdAt {

            details.append(EntryDetailInfo(title: "Created at", description: createdAt.formatted(date: .numeric, time: .standard)))
        }

        if let createdBy = detail.createdBy {

            details.append(EntryDetailInfo(title: "Created by", description: createdBy.description))
        }

        if let lastModifiedAt = detail.lastModifiedAt {

            details.append(EntryDetailInfo(title: "Last modified at", description: lastModifiedAt.formatted(date: .numeric, time: .standard)))
        }

        if let lastModifiedBy = detail.lastModifiedBy {

            details.append(EntryDetailInfo(title: "Last modified by", description: lastModifiedBy))
        }

        if let description = detail.description {

            details.append(EntryDetailInfo(title: "Description", description: description))
        }

        return details
    }
}
