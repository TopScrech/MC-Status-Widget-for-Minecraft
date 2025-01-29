import SwiftUI
import MCStatusDataLayer

struct ServerRowView: View {
    var vm: ServerStatusViewModel
    
    var body: some View {
        HStack {
            Image(uiImage: vm.serverIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 65.0, height: 65.0)
                .cornerRadius(8)
                .background(.serverIconBackground)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(hex: "6e6e6e"), lineWidth: 3)
                }
                .clipShape(.rect(cornerRadius: 8))
                .padding(.trailing, 5)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(vm.server.name)
                            .headline()
                            .foregroundColor(.primary)
                        
                        if let status = vm.status {
                            if status.status == .Offline {
                                Text(status.status.rawValue.capitalized)
                                    .subheadline()
                                    .foregroundColor(.red)
                                    .bold()
                            } else {
                                Text(status.getDisplayText())
                                    .subheadline()
                                    .secondary()
                            }
                            
                        } else if vm.loadingStatus == .Loading {
                            Text(vm.loadingStatus.rawValue)
                                .subheadline()
                                .secondary()
                        }
                    }
                    
                    Spacer()
                    
                    if vm.loadingStatus == .Loading {
                        ProgressView()
                            .padding(.trailing, 5)
                    }
                }
                
                CustomProgressView(progress: vm.getPlayerCountPercentage())
                    .frame(height: 8)
                
                if UserDefaultHelper.shared.get(for: .showUsersOnHomesreen, defaultValue: true) {
                    let sampletext = vm.getUserSampleText()
                    
                    Text(sampletext)
                        .footnote()
                        .secondary()
                        .padding(0)
                        .frame(height: 8)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
            }
        }
    }
}

//#Preview {
////    ServerRowView(title: "test", subtitle: "subtitle")
////    let vm = ServerStatusViewModel(modelContext: , server: <#T##SavedMinecraftServer#>)
//}
