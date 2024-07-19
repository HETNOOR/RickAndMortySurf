//
//  ApiError.swift
//  RickandMortySurf
//
//  Created by Максим Герасимов on 17.07.2024.
//

import Foundation

enum ApiError: Error {
    case error
    case noData
    case urlNotValidate
    case decodingError
    case encodingEror
}
