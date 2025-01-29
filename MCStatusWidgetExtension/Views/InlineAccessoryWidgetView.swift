import SwiftUI
import Intents
import WidgetKit

struct InlineAccessoryWidgetView : View {
    var entry: LockscreenProvider.Entry
    
    var body: some View {
        
#if !targetEnvironment(macCatalyst)
        HStack(spacing: 8) {
            if let statusIcon = entry.viewModel.statusIcon {
                Image(systemName: statusIcon)
                    .fontSize(18)
                    .widgetAccentable()
            } else {
                Image(uiImage: entry.viewModel.icon).widgetAccentable()
            }
            
            Button(intent: RefreshWidgetIntent()) {
                if entry.viewModel.viewType == .Unconfigured {
#if os(watchOS)
                    Text("...")
#else
                    Text("Edit Widget")
#endif
                } else {
                    Text(entry.viewModel.progressString)
                }
            }
            .buttonStyle(.plain)
        }
#endif
    }
}


#if !targetEnvironment(macCatalyst)
struct MinecraftServerStatusHSWidget_InlinePreview: PreviewProvider {
    static var previews: some View {
        MinecraftServerStatusLSWidgetEntryView(entry: ServerStatusLSSnapshotEntry(date: Date(), configuration: ServerSelectNoThemeWidgetIntent(), viewModel: WidgetEntryViewModel()))
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
#endif
