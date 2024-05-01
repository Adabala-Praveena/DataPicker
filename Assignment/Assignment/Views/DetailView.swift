//
//  DetailView.swift
//  Assignment
//
//  Created by Praveena on 01/05/24.
//

import SwiftUI

/// A view representing a detail view for displaying InputData details.
/// It displays title and details with cross button to dismiss the view.

struct DetailView: View {
    /// The InputData to display details for.
    
    let InputData: InputData
    /// Binding to control the presentation of the sheet containing this detail view.
    
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(InputData.title)
                    .font(.title)
                    .padding(.bottom)
                Spacer()
                Button(action: {
                    self.isSheetPresented = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                }
                .padding()
            }
            
            Text(InputData.body)
        }
        .padding()
    }
}

#Preview {
    DetailView(InputData: InputData(id: 1, title: "iOS developer", body: "An iOS developer creates software applications and programs for iOS-based devices. Here’s what to know about an iOS developer’s needed skills, salary and how to become one."), isSheetPresented: .constant(true))
}
