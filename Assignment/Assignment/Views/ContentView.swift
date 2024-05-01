//
//  ContentView.swift
//  Assignment
//
//  Created by Praveena on 01/05/24.
//
import SwiftUI

/**
 The main view responsible for displaying a list of data items and presenting a detail view which adapts its size based on the text when a cell is tapped.

 - Parameters:
    - dataArr: An array of `InputData` objects representing the data items to be displayed in the list.
    - isSheetPresented: A boolean value indicating whether the detail view is currently presented as a sheet.
    - InputData: An optional `InputData` object representing the selected data item in the list.
    - isLoading: A boolean value indicating whether data is currently being fetched.
    - sheetViewHeight: A CGFloat value representing the height of the sheet view.
    - isDataFetched: A boolean value indicating whether the data has been fetched from the network.
 */

struct ContentView: View {
    
    @State private var dataArr: [InputData] = []
    @State private var isSheetPresented = false
    @State private var InputData: InputData? = nil
    @State private var isLoading = false
    @State private var sheetViewHeight: CGFloat = .zero
    @State private var isDataFetched = false
    
    
    var body: some View {
        NavigationView {
            VStack{
                if isLoading {
                    ProgressView("Please wait while the data is being fetched...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    List(dataArr) { InputData in
                        Button(action: {
                            self.InputData = InputData
                            self.fetchCellDataDetails()
                        }) {
                            CustomCell(InputData: InputData)
                        }
                    }
                    .navigationBarTitle("Posts")
                    .sheet(isPresented: $isSheetPresented) {
                        if let InputData = InputData {
                            DetailView(InputData: InputData, isSheetPresented: $isSheetPresented)
                                .fixedSize(horizontal: false, vertical: true)
                                .modifier(GetHeightModifier(height: $sheetViewHeight))
                                .presentationDetents([.height(sheetViewHeight)])
                        }
                    }
                    .onAppear {
                        if !isDataFetched {
                            fetchData()
                            isDataFetched = true
                        }
                    }
                }
            }
        }
    }
    
    /**
         Fetches data from the network if it has not been fetched already.
    */
    func fetchData() {
        guard !isLoading else { return }
        isLoading = true
        NetworkManager.shared.fetchData() { result in
            isLoading = false // Hide loading indicator
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    dataArr.append(contentsOf: data)
                }
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
    
    
    func fetchCellDataDetails() {
        guard let _ = InputData else { return }
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() ) {
            self.isLoading = false
            self.isSheetPresented = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/// A view modifier that adjusts the height of its content based on the geometry of its background.

struct GetHeightModifier: ViewModifier {
    /// Binding to the height value that will be updated based on the geometry.
    
    @Binding var height: CGFloat
    
    /// Adjusts the height of the content based on the geometry of its background.
    /// - Parameter content: The content view to which this modifier is applied.
    /// - Returns: A view with the modified height.
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geometry -> Color in
                DispatchQueue.main.async {
                    height = geometry.size.height
                }
                return Color.clear
            }
        )
    }
}
