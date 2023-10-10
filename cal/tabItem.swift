//
//  tabItem.swift
//  cal
//
//  Created by Rimah on 26/03/1445 AH.
//

import SwiftUI

struct tabItem: View {
    var body: some View {
        
        
        TabView {
            NavigationStack {
                isearch()
                    .tabItem {
                        Label("", systemImage: "house.fill")
                    }
                    }
                recommendation()
                    .tabItem {
                        Label("", systemImage: "star.fill")
                    }
                info()
                    .tabItem {
                        Label("", systemImage: "minus.forwardslash.plus")
                    }
            }
        }
    }
    

#Preview {
    tabItem()
}
