//
//  NavigationBar.swift
//  Messenger
//
//  Created by Leandro Hernandez on 11/3/22.
//

import SwiftUI

struct NavigationBar: View {
    
    var body: some View {
        ZStack {
            Color.clear
                .background(Color.white)

            HStack {
                Image("001")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 46, height: 46, alignment: .center)
                    .cornerRadius(23)
                    .padding(.leading, 16)
                
                Spacer(minLength: 8)
                
                Text("Messages")
                    .font(.system(size: 30).weight(.bold))
                    .foregroundColor(Color.ui.spaceCadet)
                
                Spacer(minLength: 8)
                
                Button {
                    
                } label: {
                    Image(systemName: "magnifyingglass")
                }
                .frame(width: 46, height: 46, alignment: .center)
                .background(Color.ui.platinum)
                .cornerRadius(23)
                .foregroundColor(Color.ui.spaceCadet)
                .padding(.trailing, 16)
            }
        }
        .frame(height: 68)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
