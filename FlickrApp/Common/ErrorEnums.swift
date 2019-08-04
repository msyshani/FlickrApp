//
//  ErrorEnums.swift
//  FlickrApp
//
//  Created by Mahendra Yadav on 04/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import Foundation

enum FlickrServiceError: Error {
    case invalidImageData
    case invalidRequest
    case parsingFailed
    case noData
    /// Error when the retrieved image could not be parsed.
}

extension FlickrServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidImageData:
            return NSLocalizedString(
                "Invalid image data",
                comment: ""
            )
        case .invalidRequest:
            return NSLocalizedString(
                "We are unable to process your request, Please try again later",
                comment: ""
            )
        case .parsingFailed:
            return NSLocalizedString(
                "We are unable to parse your request, Please try after some time",
                comment: ""
            )
        case .noData:
            return NSLocalizedString(
                "No image found for your search",
                comment: ""
            )
        }
    }
}
