//
//  StatsView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2024-06-02.
//

import SwiftUI

struct StatsView: View {
    
    // MARK: Stored properties
    
    // Whether this view is showing in the sheet right now
    @Binding var showing: Bool
    
    @State var uniquePagesCount: Int = 0
    
    @Environment(BookStore.self) var book

    // MARK: Computed properties
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(uniquePagesCount)")
                Text("Hello")
            }
            .padding()
            .navigationTitle("Statistics")
            // Toolbar to show buttons for various actions
            .toolbar {
                
                // Hide this view
                ToolbarItem(placement: .automatic) {
                    Button {
                        showing = false
                    } label: {
                        Text("Done")
                            .bold()
                    }

                }
            }
        }
        .task {
            do {
                uniquePagesCount = try await book.getCountOfUniquePages(userId: book.reader.id ?? 0)
            } catch {
                print("Problem getting page count")
            }
        }
    }
    
}

#Preview {
    StatsView(showing: Binding.constant(true))
}
