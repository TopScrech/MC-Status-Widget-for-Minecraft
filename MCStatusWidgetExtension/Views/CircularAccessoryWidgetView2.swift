import SwiftUI
import Intents
import WidgetKit

struct CircularAccessoryWidgetView2 : View {
    var entry: LockscreenProvider.Entry
    
    var body: some View {
#if !targetEnvironment(macCatalyst)
        Gauge (value: entry.viewModel.progressValue) {
            ZStack {
                if let statusIcon = entry.viewModel.statusIcon {
                    Image(systemName: statusIcon)
                        .fontSize(24)
                        .padding(4)
                } else if entry.viewModel.viewType == .Unconfigured {
#if os(watchOS)
                    Text("...").padding(2) .multilineTextAlignment(.center)
#else
                    Text("Edit Widget").padding(2) .multilineTextAlignment(.center)
#endif
                } else {
                    if #available(iOSApplicationExtension 18, watchOS 11, *)  {
                        Image(uiImage: entry.viewModel.icon).resizable()
                            .widgetAccentedRenderingMode(.accentedDesaturated)
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(0)
                            .offset(y: -1)
                            .widgetAccentable()
                    } else {
                        Image(uiImage: entry.viewModel.icon).resizable()
                            .scaledToFit().frame(width: 25, height: 25)
                            .padding(0)
                            .widgetAccentable()
                            .offset(y: -1)
                    }
                }
                
                Button(intent: RefreshWidgetIntent()) {
                    Color.clear
                }
                .buttonStyle(.plain)
            }
        }
        .gaugeStyle(.accessoryCircularCapacity)
#endif
    }
}

#if !targetEnvironment(macCatalyst)
struct MinecraftServerStatusLSWidget_CircularPreview2: PreviewProvider {
    static var previews: some View {
        MinecraftServerStatusLSWidgetEntryView(entry: ServerStatusLSSnapshotEntry(date: Date(), configuration: ServerSelectNoThemeWidgetIntent(), viewModel: WidgetEntryViewModel()), widgetType: .OnlyImage)
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
#endif
