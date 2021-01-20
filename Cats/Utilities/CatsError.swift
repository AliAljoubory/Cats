//
//  CatsError.swift
//  Cats
//
//  Created by Ali Aljoubory on 28/12/2020.
//

import UIKit

enum CatsError: String, Error {
    
    case invalidRequest = "Invalid URL request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data recieved from the server is invalid. Please try again."
}
