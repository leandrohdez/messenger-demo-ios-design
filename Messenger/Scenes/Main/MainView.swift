//
//  MainView.swift
//  Messenger
//
//  Created by Leandro Hernandez on 4/3/22.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel: MainViewModel

    //
    init(viewModel: MainViewModel = .init()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                    .frame(height: 70)
                
                List {
                    
                    Section(
                        header: Text("Pinned chat")
                            .font(.system(size: 19).weight(.bold))
                            .foregroundColor(Color.ui.spaceCadet)
                    ) {
                        ForEach(self.viewModel.pinned) { contact in
                            ChatRow(contact: contact)
                        }
                    }
                    
                    Section(
                        header: Text("Recent chat")
                            .font(.system(size: 19).weight(.bold))
                            .foregroundColor(Color.ui.spaceCadet)
                    ) {
                        ForEach(self.viewModel.contacts) { contact in
                            ChatRow(contact: contact)
                        }
                    }
                }
                .padding(.bottom, 100)
                .listStyle(.plain)
                .onAppear {
                    self.loadContacts()
                }
                
            }
        }
        .navigationBarHidden(true)
        .overlay {
            ZStack{
                NavigationBar()
                TabBarView()
            }
        }
    }
}

struct ChatRow: View {
    
    var contact: Models.ContactModel
    
    var body: some View {
        
        NavigationLink {
            ChatView(viewModel: ChatViewModel(contact: contact))
        } label: {
            HStack(spacing: 16) {
                Image(contact.user.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
                VStack(alignment: .leading, spacing: 8) {
                    Text(contact.user.name)
                        .font(.system(size: 19).weight(.bold))
                        .foregroundColor(Color.ui.spaceCadet)
                    Text("bla bla bla bla bla...")
                        .font(.system(size: 14).weight(.medium))
                        .foregroundColor(Color.ui.platinum)
                }
                Spacer(minLength: 0)
                VStack(alignment: .trailing, spacing: 8) {
                    Text("13h")
                        .font(.system(size: 13).weight(.bold))
                        .foregroundColor(Color.ui.spaceCadet)
                    Circle()
                        .fill(Color.ui.ultramarineBlue)
                        .frame(width: 8, height: 8)
                }
            }
        }
        .listRowSeparator(.hidden)
    }
}

// MARK: - Fetching Data
extension MainView {
    
    //
    private func loadContacts() {
        self.viewModel.fetchContacts()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
