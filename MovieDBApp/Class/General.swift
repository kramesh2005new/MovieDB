//
//  General.swift
//  MovieDBApp
//
//  Created by Ramesh on 08/03/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class General: NSObject {
    
    func formatDate(dateStr: String) -> String
    {
        var dateFormatter : DateFormatter!
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        
        if let releaseDate = dateFormatter.date(from: dateStr)
        {
            var dateFormatterToStr : DateFormatter!
            dateFormatterToStr = DateFormatter()
            dateFormatterToStr.dateFormat = "dd/MM/yyyy"
            dateFormatterToStr.timeZone = TimeZone.current
            dateFormatterToStr.locale = Locale.current
            
            return dateFormatterToStr.string(from: releaseDate)
        }
        
        
        return ""
    }

}
