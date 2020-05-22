//
//  Data+JSON.swift
//  Alamofire
//
//  Created by Ahmad Almasri on 5/22/20.
//

import Foundation

extension Data {
    var jsonString: NSString? {
        guard
            let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let prettyPrintedData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            else { return nil }

        return NSString(data: prettyPrintedData, encoding: String.Encoding.utf8.rawValue)
    }

    var json: Any? {
        return try? JSONSerialization.jsonObject(with: self, options: .allowFragments)
    }
}
