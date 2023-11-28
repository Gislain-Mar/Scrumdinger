//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by Gislain Marlhens on 19/10/2023.
//

import SwiftUI

struct ErrorView: View {
    
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("An error has occurred!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum SampeError: Error {
        case errorRequired
    }
    
    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: SampeError.errorRequired, guidance: "You can safely ignore this error.")
    }
    
    static var previews: some View{
       ErrorView(errorWrapper: wrapper)
    }
}
