//
//  ContentView.swift
//  MCStatusWatchApp Watch App
//
//  Created by Tomer Shemesh on 8/7/23.
//

import SwiftUI
import SwiftData
import CloudKit
import CoreData


func testServer() -> SavedMinecraftServer {
    return SavedMinecraftServer(id: UUID(), serverType: .Java, name: "Hodor", serverUrl: "zero.minr.org", serverPort: 25565)
}

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State private var serverViewModels: [ServerStatusViewModel] = []
    @State private var serverViewModelCache: [UUID:ServerStatusViewModel] = [:]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(serverViewModels) { viewModel in
                    NavigationLink {
                        // add detail screen here
                    }
                    label: {
                        if let status = viewModel.status {
                            Text(viewModel.server.name + " - " + status.getDisplayText())
                        } else {
                            Text(viewModel.server.name + " - " + viewModel.loadingStatus.rawValue)
                        }
                    }
                }

            }
            .toolbar {
                if !serverViewModels.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
    //                        reloadData(forceRefrfesh)
                        } label: {
                            Label("Refresh", systemImage: "arrow.clockwise")
                        }
                    }
                }
            }
        }
        .overlay {
            if serverViewModels.isEmpty {
                VStack {
                    Spacer()
                    Image (systemName: "server.rack")
                    .font (.system(size: 30))
                    .foregroundStyle(.gray)
                    ContentUnavailableView("Add a Server", systemImage: "",
                       description: Text ("Let's get started! Add a server using your phone."))
                    .scrollDisabled(true)
                    Spacer()
                }.padding()
               
            }
        }

        .onReceive(NotificationCenter.default.publisher(for: NSPersistentCloudKitContainer.eventChangedNotification)) { notification in
            guard let event = notification.userInfo?[NSPersistentCloudKitContainer.eventNotificationUserInfoKey] as? NSPersistentCloudKitContainer.Event else {
                return
            }
            
            // may have gotten new/changed data refresh models from database
            if event.endDate != nil && event.type == .import {
                reloadData()
            }
        }.onAppear {
            let vm = ServerStatusViewModel(server: testServer())
//            serverViewModels.append(vm)
        }
    }
    
    private func reloadData() {
        let fetch = FetchDescriptor<SavedMinecraftServer>(
            predicate: nil,
            sortBy: [.init(\.displayOrder)]
        )
        guard let results = try? modelContext.fetch(fetch) else {
            return
        }
        
        print(results.count)
    }
}

//#Preview {
//    ContentView()
//}
