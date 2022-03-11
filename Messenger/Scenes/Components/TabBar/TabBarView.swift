//
//  TabBarView.swift
//  Messenger
//
//  Created by Leandro Hernandez on 11/3/22.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        ZStack {
            Color.clear
                .background(Color.white)

            HStack {
                
                Spacer(minLength: 8)
                
                Button {
                    self.selectedIndex = 0
                } label: {
                    Image(systemName: "message.fill")
                        .font(.system(size: 28))
                }
                .frame(width: 46, height: 46, alignment: .center)
                .foregroundColor((self.selectedIndex == 0) ? Color.ui.ultramarineBlue : Color.gray)
                .padding()
                
                Spacer(minLength: 8)
                    
                Button {
                    self.selectedIndex = 1
                } label: {
                    Image(systemName: "phone.fill")
                        .font(.system(size: 28))
                }
                .frame(width: 46, height: 46, alignment: .center)
                .foregroundColor((self.selectedIndex == 1) ? Color.ui.ultramarineBlue : Color.gray)
                .padding()
                
                Spacer(minLength: 8)
                
                Button {
                    self.selectedIndex = 2
                } label: {
                    Image(systemName: "person.fill")
                        .font(.system(size: 28))
                }
                .frame(width: 46, height: 46, alignment: .center)
                .foregroundColor((self.selectedIndex == 2) ? Color.ui.ultramarineBlue : Color.gray)
                .padding()
                
                Spacer(minLength: 8)
            }
        }
        .frame(height: 68)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
