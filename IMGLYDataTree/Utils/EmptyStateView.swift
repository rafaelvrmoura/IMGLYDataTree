//
//  EmptyStateView.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Empty").font(.title3)
        }.padding()
    }
}

#Preview {
    EmptyStateView()
}
