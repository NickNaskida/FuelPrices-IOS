//
//  FuelPricesWidgets.swift
//  FuelPricesWidgets
//
//  Created by Nikoloz Naskidashvili on 13.03.23.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(for configuration: SelectFuelTypeIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(for configuration: SelectFuelTypeIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct FuelPricesWidgetsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct FuelPricesWidgets: Widget {
    let kind: String = "FuelPricesWidgets"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SelectFuelTypeIntent.self, provider: Provider()) { entry in
            FuelPricesWidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("Best Deals")
        .description("Shows fuel type best deals accross all providers.")
        .supportedFamilies([.systemSmall])
    }
}

struct FuelPricesWidgets_Previews: PreviewProvider {
    static var previews: some View {
        FuelPricesWidgetsEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
