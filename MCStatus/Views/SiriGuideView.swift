import SwiftUI

struct SiriPhrase: Identifiable {
    let id = UUID()
    let phrase: String
}

struct SiriGuideView: View {
    private let phrases = [
        SiriPhrase(phrase: "Check the status of my (Minecraft) server"),
        SiriPhrase(phrase: "What's the status of my (Minecraft) server"),
        SiriPhrase(phrase: "Check the status of [SERVER NAME]"),
        SiriPhrase(phrase: "What's the status of [SERVER NAME]"),
        SiriPhrase(phrase: "Check [SERVER NAME]'s status for me"),
    ]
    
    @State var tipVisibility = true
    
    var body: some View {
        Form {
            //            Looks bad dont bother using build in view
            //            SiriTipView(intent: SavedServerStatusOnlineCheckIntent(), isVisible: $tipVisibility)
            Section(header: Text("How to Use Siri with MC Status")
                .title2()
                .bold()
                .padding(.bottom, 5)) {
                    ForEach(phrases) { phrase in
                        HStack {
                            Image(systemName: "mic.fill")
                                .foregroundColor(.blue)
                                .imageScale(.large)
                                .padding(.trailing, 5)
                            
                            Text("\"\(phrase.phrase)\"")
                                .subheadline()
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 5)
                    }
                }
                .headerProminence(.increased)
        }
        .navigationTitle("Siri")
        .background(Color(.systemGroupedBackground))
    }
}

