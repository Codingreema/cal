//
//  splashscreen.swift
//  cal
//
//  Created by Rimah on 27/03/1445 AH.
//

import SwiftUI

struct splashscreen: View {
    @State var isActive : Bool = false
    @State private var size = 0.3
        @State private var opacity = 0.3
        
         
        var body: some View {
         if isActive {
             cal.tabItem()
            } else {
                VStack {
                    VStack {
                        Image("Image")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 128, height: 128)
     
                        Text("نمى... لتستثمر بثقه")
                            .font(Font.custom("SFProARDisplay-Semibold", size: 26))
                            .foregroundColor(.black.opacity(0.80))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.6)) {
                            self.size = 0.9
                            self.opacity = 1.00
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
#Preview {
    splashscreen()
        .environment(\.layoutDirection, .rightToLeft)
}
