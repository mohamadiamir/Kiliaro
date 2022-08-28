//
//  String+Extension.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/26/22.
//

import Foundation

extension String {
    func checkURLIsValid()->URL? {
        if self.count > 0,
           let urlEncoded = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlEncoded){
            return url
        }
        return nil
    }
    
    func convertDateToReadable()->String{
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        let oldDate = olDateFormatter.date(from: self)
        guard let oldDate = oldDate else {
            return ""
        }
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "yyyy-MM-dd h:mm a"
        let final = convertDateFormatter.string(from: oldDate)
        return final
    }
}
