//
//  DatePickerExtension.swift
//  Halal
//
//  Created by hamza Ahmed on 15.11.19.
//  Copyright © 2019 Hamza. All rights reserved.
//

import UIKit

extension UIDatePicker {

    func setLimit(forCalendarComponent component:Calendar.Component, minimumUnit min: Int, maximumUnit max: Int) {

        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)

        guard let timeZone = TimeZone(identifier: "UTC") else { return }
        calendar.timeZone = timeZone

        var components: DateComponents = DateComponents()
        components.calendar = calendar

        components.setValue(-min, for: component)
        if let maxDate: Date = calendar.date(byAdding: components, to: currentDate) {
            self.maximumDate = maxDate
        }

        components.setValue(-max, for: component)
        if let minDate: Date = calendar.date(byAdding: components, to: currentDate) {
            self.minimumDate = minDate
        }
    }

}
