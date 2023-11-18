//
//  IMGLYDataTreeApp.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import SwiftUI
import SwiftData

@main
struct IMGLYDataTreeApp: App {

    let service = IMGLYServiceLayer()

    var body: some Scene {
        WindowGroup {
            TreeView(service: service)
        }
    }
}
