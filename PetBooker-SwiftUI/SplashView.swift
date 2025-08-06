//
//  SplashView.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 22/5/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            LoginView(viewModel: LoginViewModel())
        } else {
            ZStack {
                Color(red: 0.941, green: 0.384, blue: 0.467)
                    .ignoresSafeArea()

                VStack {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 160, height: 160)

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
                .opacity(isActive ? 0 : 1)
                .scaleEffect(isActive ? 0.9 : 1)
                .animation(.easeInOut(duration: 0.5), value: isActive)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}


#Preview {
    SplashView()
}
