//
//  Converter.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/09.
//

import Foundation

class Converter {
    class func numberToStringWithComma(number: Int) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let convertedNumber: String? = numberFormatter.string(from: NSNumber(value: number))
        return convertedNumber
    }
}
