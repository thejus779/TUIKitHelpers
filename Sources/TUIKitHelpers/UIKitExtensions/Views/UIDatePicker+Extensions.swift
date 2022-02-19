//
//  UIDatePicker+Extensions.swift
//
//
//  Created by Thejus Thejus on 19/02/2022.
//

import Foundation
import UIKit

extension UIDatePicker {
    static func datePickerNeedingMajority() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.date = Date.fromDMY(Date.defaultDate)!
        datePicker.locale = Locale.current
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        return datePicker
    }
    
    static func datePickerAtCurrentDate() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.date = Date()
        datePicker.locale = Locale.current
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        return datePicker
    }
}
