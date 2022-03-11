//
//  MessageBarView.swift
//  Messenger
//
//  Created by Leandro Hernandez on 9/3/22.
//

import SwiftUI

struct MessageBarView: View {
    
    @State private var message: String = ""
    
    @State var onSend: ((_ message: String) -> Void)?
    
    var body: some View {
        ZStack {
            Color.white
            HStack(spacing: 16) {
                
                HStack {
                    Spacer().frame(width: 16)
                    TextField("Message...", text: self.$message)
                        .foregroundColor(Color.ui.spaceCadet)
                    Spacer().frame(width: 16)
                }
                .frame(height: 48)
                .background(Color.ui.platinum)
                .cornerRadius(24)
                
                Button {
                    self.sendButtonTapped()
                    
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color.ui.light)
                }
                .frame(width: 52, height: 52)
                .background(Color.ui.ultramarineBlue)
                .cornerRadius(26)
            }
            .padding()
        }
        .frame(height: 60)
    }
}

//
extension MessageBarView {
    
    //
    private func sendButtonTapped() {
        if !self.message.isEmpty {
            self.onSend?(self.message)
            self.message = ""
        }
    }
    
}

struct MessageBarView_Previews: PreviewProvider {
    static var previews: some View {
        MessageBarView()
    }
}
