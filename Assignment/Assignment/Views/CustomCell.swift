//
//  CustomCell.swift
//  Assignment
//
//  Created by Praveena on 01/05/24.
//

import SwiftUI

/// A view representing a cell displaying a InputData.
struct CustomCell: View {
    /// The InputData to display in the cell.
    let InputData: InputData
    
    var body: some View {
        VStack {
            Text("\(InputData.id): \(InputData.title)")
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading) // Align text to the leading edge
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(6)
        }
    }
}
#Preview {
    CustomCell(InputData: InputData(id: 1, title: "iOS developer", body: "An iOS developer creates software applications and programs for iOS-based devices. Here’s what to know about an iOS developer’s needed skills, salary and how to become one."))
}
