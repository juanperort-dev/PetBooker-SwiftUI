//
//  DashboardView.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 28/7/25.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel: DashboardViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DashboardView(viewModel: DashboardViewModel())
}
