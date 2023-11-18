//
//  EntryDetail.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import Foundation

struct EntryDetail: Decodable {

    let id: String?
    let createdAt: Date?
    let createdBy: String?
    let lastModifiedAt: Date?
    let lastModifiedBy: String?
    let description: String?
}

