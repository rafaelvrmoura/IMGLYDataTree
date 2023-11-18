//
//  IMGLYAPI.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import Foundation

enum IMGLYAPI {

    case tree
    case entryDetails(id: String)

    var url: URL {

        switch self {

        case .tree:
            return URL(string: "https://ubique.img.ly/frontend-tha/data.json")!
        case .entryDetails(let id):
            return URL(string: "https://ubique.img.ly/frontend-tha/entries/\(id).json")!

        }
    }
}
