//
//  NetworkManager.swift
//  Swift.cource.hw
//
//  Created by mirrindahh on 07.07.2023.
//

import Foundation

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

/**
 Types of network errors
 ### Properties
 - **InvalidURL**.
 - **JSONDecodingError**
 - **RequestError**
 - **UnknownError**
 */
enum NetworkHandlerError: Error {
    case InvalidURL
    case JSONDecodingError
    case RequestError(String)
    case UnknownError
}

struct ResponseErrorMessage: Codable {
    let error: String
}

/**
 Struct for handling network requests and decoding JSON data
 ### Functions
 - **performAPIRequestByMethod**
 - **performAPIRequestByURL**
 - **decodeJSONData**
 */
public struct NetworkHandler {
    var baseURL: String = "https://rickandmortyapi.com/api/"
    
    /**
     Perform API request with given method.
     - Parameters:
        - method: URL for API request.
     - Returns: HTTP data response.
     */
    func performAPIRequestByMethod(method: String) async throws -> Data {
        if let url = URL(string: baseURL+method) {
            print("📮 RequestURL: \(baseURL)\(method)")
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
               let error: ResponseErrorMessage = try decodeJSONData(data: data)
               throw NetworkHandlerError.RequestError(error.error)
            }
            return data
        } else {
            throw(NetworkHandlerError.InvalidURL)
        }
    }
    
    /**
     Perform API request with given URL.
     - Parameters:
        - url: URL for API request.
     - Returns: HTTP data response.
     */
    func performAPIRequestByURL(url: String) async throws -> Data {
        if let url = URL(string: url) {
            print("📮 RequestURL: \(url)")
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
               let error: ResponseErrorMessage = try decodeJSONData(data: data)
               throw NetworkHandlerError.RequestError(error.error)
            }
            return data
        } else {
            throw(NetworkHandlerError.InvalidURL)
        }
    }
    
    /**
     Decode JSON response for codable struct model.
     - Parameters:
        - data: HTTP data response.
     - Returns: Model struct of associated variable type.
     */
    func performAPIRequestAndParseResponse(method: String) async throws -> CharacterMod {
            // Perform the API request to get the response data
            let responseData = try await performAPIRequestByMethod(method: method)
            
            // Parse the API response data
            let decoder = JSONDecoder()
            do {
                let parsedData = try decoder.decode(RMCharacterModel.self, from: responseData)
                
                guard let appDelegate = await UIApplication.shared.delegate as? AppDelegate else {
                    fatalError("AppDelegate not found")
                }
                // Access the relevant data from the parsed response (e.g., parsedData.name, parsedData.status, etc.)
                let name = parsedData.name
                let status = parsedData.status
                let species = parsedData.species
                let type = parsedData.type
                let gender = parsedData.gender
                let location = parsedData.location
                
                // Create a new instance of your Core Data entity and set its attributes
                let managedObjectContext = await appDelegate.managedObjectContext // Replace appDelegate with the actual reference to your app delegate
                let entity = CharacterMod(context: managedObjectContext)
                entity.name = name
                entity.status = status
                entity.species = species
                entity.type = type
                entity.gender = gender
                entity.location = location.name
                
                // Save the context to persist the changes to disk
                do {
                    try managedObjectContext.save()
                    print("Data saved successfully")
                } catch {
                    print("Error saving context: \(error)")
                }
                
                // Return the created entity or any other result you need
                return entity
            } catch {
                print("Error parsing API response: \(error)")
                throw error
            }
        }
        
}
