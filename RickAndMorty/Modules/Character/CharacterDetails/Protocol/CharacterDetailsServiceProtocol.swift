//  
//  CharacterDetailsServiceProtocol.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import Foundation

protocol CharacterDetailsServiceProtocol {

    /// SAMPLE FUNCTION -* Please rename this function to your real function
    ///
    /// - Parameters:
    ///   - success: -- success closure response, add your Model on this closure.
    ///                 example: success(_ data: YourModelName) -> ()
    ///   - failure: -- failure closure response, add your Model on this closure.  
    ///                 example: success(_ data: APIError) -> ()
    func removeThisFuncName(success: @escaping(_ data: CharacterDetailsModel) -> Void,
                            failure: @escaping() -> Void)

}
