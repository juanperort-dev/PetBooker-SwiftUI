//
//  SplashView.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 22/5/25.
//

import SwiftUI

struct SplashView: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            Color(red: 0.941, green: 0.384, blue: 0.467)
                .ignoresSafeArea()
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 160, height: 160)
                        .scaleEffect(animate ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 0.8).repeatForever(), value: animate)
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 160, height: 160)
                        .clipShape(Circle())
                }
                Text("PetBooker")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .textCase(.uppercase)
                    .padding(.top, 20)
            }
            .onAppear {
                animate = true
            }
        }
    }
}

#Preview {
    SplashView()
}
