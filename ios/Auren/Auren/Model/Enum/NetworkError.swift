//
//  NetworkError.swift
//  Auren
//
//  Created by Mattis Lefranc Adam on 29.07.2026.
//


enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(Error) 
}
