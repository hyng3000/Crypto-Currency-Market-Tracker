//
//  Double.swift
//  CryptoTracker
//
//  Created by Hamish Young on 22/3/2023.
//

import Foundation

extension Double {

    /**
    Number formatter instance that Converts a Double into a formatted Currency with 0-2 decimal places
     */
    private var currencyFormatterForTwoDecmials: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        return formatter
    }
    
    /**
        Converts a Double into a Currency String with two decimal places
     */
    func asCurrencyWithTwoDecimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatterForTwoDecmials.string(from: number) ?? "$0.00"
    }


    /**
    Number formatter instance that Converts a Double into a formatted Currency with 4-6 decimal places
     */
    private var currencyFormatterForSixDecmials: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 6
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    /**
        Converts a Double into a Currency String with 6 decimal places
     */
    func asCurrencyWithSixDecimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatterForSixDecmials.string(from: number) ?? "$0.00"
    }
    
    
    /**
    Converts a number to a String with two deimals
     */
    func asNumberString() -> String {
        return String(format:"%.2f", self)
    }
    
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
        
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// credit -> 'trndjc' https://stackoverflow.com/questions/48371093/swift-4-formatting-numbers-into-friendly-ks
    func formattedWithAbbreviation() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }
}

