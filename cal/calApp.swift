//
//  calApp.swift
//  cal
//
//  Created by Rimah on 25/03/1445 AH.
//

import SwiftUI

@main
 struct calApp: App {
     init() {
         let appear = UINavigationBarAppearance()

         let atters: [NSAttributedString.Key: Any] = [
             .font: UIFont(name: "SFProARDisplay-Semibold", size: 32)!
         ]

         appear.largeTitleTextAttributes = atters
         appear.titleTextAttributes = atters
         UINavigationBar.appearance().standardAppearance = appear
         UINavigationBar.appearance().compactAppearance = appear
         
      }
   
     var body: some Scene {
        WindowGroup {
        
        isearch()
                .environment(\.layoutDirection, .rightToLeft)
                .background(Color.black.opacity(0.05))
                
        
        }
    }
}
