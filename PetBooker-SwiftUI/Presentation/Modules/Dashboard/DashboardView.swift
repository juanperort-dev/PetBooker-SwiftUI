//
//  DashboardView.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 28/7/25.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        VStack {
            Text("¡Dashboard Cargado!")
                .font(.largeTitle)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow.opacity(0.1))
    }
}

#Preview {
    DashboardView(viewModel: DashboardViewModel())
}
