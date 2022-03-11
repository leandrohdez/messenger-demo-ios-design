//
//  BackNavigationBar.swift
//  Messenger
//
//  Created by Leandro Hernandez on 11/3/22.
//

import SwiftUI

struct BackNavigationBar: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var title: String = ""
    
    var body: some View {
        ZStack {
            Color.clear
                .background(Color.white)

            HStack {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                }
                .frame(width: 46, height: 46, alignment: .center)
                .background(Color.ui.platinum)
                .cornerRadius(23)
                .foregroundColor(Color.ui.spaceCadet)
                .padding(.leading, 16)
                
                Text(self.title)
                    .font(.system(size: 19).weight(.bold))
                    .foregroundColor(Color.ui.spaceCadet)
                    .padding(.leading, 8)
                
                Spacer(minLength: 8)
                
                Button {
                    
                } label: {
                    Image(systemName: "magnifyingglass")
                }
                .frame(width: 46, height: 46, alignment: .center)
                .background(Color.ui.platinum)
                .cornerRadius(23)
                .foregroundColor(Color.ui.spaceCadet)
               
                Spacer(minLength: 8).frame(width: 8)
                
                Button {
                    
                } label: {
                    Image(systemName: "phone.fill")
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

struct BackNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        BackNavigationBar()
    }
}

