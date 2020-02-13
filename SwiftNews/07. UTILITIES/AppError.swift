//
//  AppError.swift
//  SwiftNews
//
//  Created by BES on 2020-02-13.
//  Copyright © 2020 BEstelrich. All rights reserved.
//

import Foundation

enum AppError: String, Error {
  
  case invalidURL       = "The provided URL is invalid."
  case unableToComplete = "Unable to complete your request. Please check your internet connection."
  case invalidData      = "The data received from the server was invalid. Please try again."
  
}
