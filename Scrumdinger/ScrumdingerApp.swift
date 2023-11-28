//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Gislain Marlhens on 09/10/2023.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?

    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $store.scrums) {
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "ScrumDinger will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper) {
                store.scrums = DailyScrum.sampleData
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
