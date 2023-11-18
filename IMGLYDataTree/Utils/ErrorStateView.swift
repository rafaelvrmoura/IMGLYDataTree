//
//  ErrorStateView.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import SwiftUI

struct ErrorStateView: View {

    let errorMessage: String

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "x.circle")
                .font(.title)
                .foregroundStyle(.red)

            Text(errorMessage).font(.title3)
        }.padding()
    }
}

#Preview {
    ErrorStateView(errorMessage: "Something went wrong!")
}
