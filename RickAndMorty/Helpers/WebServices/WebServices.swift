//
//  WebServices.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import Foundation
import RxSwift

public enum APIErrors: Error {
    case seralizationError(error: Error)
    case apiError(message: String)
    case domainError(error: Error)
}
public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    /// `CONNECT` method.
    public static let connect = HTTPMethod(rawValue: "CONNECT")
    /// `DELETE` method.
    public static let delete = HTTPMethod(rawValue: "DELETE")
    /// `GET` method.
    public static let get = HTTPMethod(rawValue: "GET")
    /// `HEAD` method.
    public static let head = HTTPMethod(rawValue: "HEAD")
    /// `OPTIONS` method.
    public static let options = HTTPMethod(rawValue: "OPTIONS")
    /// `PATCH` method.
    public static let patch = HTTPMethod(rawValue: "PATCH")
    /// `POST` method.
    public static let post = HTTPMethod(rawValue: "POST")
    /// `PUT` method.
    public static let put = HTTPMethod(rawValue: "PUT")
    /// `TRACE` method.
    public static let trace = HTTPMethod(rawValue: "TRACE")
    public let rawValue: String
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HTTPMethod = .get
    var body: Data?
}
extension Resource {
    init(url: URL) {
        self.url = url
    }
}
enum CustomError: String, Error {
    case dataIsNil = "No data"
}

struct APIError: Decodable, Error {
    let errorMessage: String

    enum CodingKeys: String, CodingKey {
        case errorMessage = "error"
    }
}
class WebServices {
    let decoder = JSONDecoder()
    static let shared = WebServices()
    
    func load<T>(resource: Resource<T>) async throws -> T {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let data: T = try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self = self else { return }
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    guard let data = data else {
                        continuation.resume(throwing: CustomError.dataIsNil)
                        return
                    }
                    do {
                        guard let urlResponse = response as? HTTPURLResponse,
                              (200...299).contains(urlResponse.statusCode) else {
                                  let decodedErrorResponse = try self.decoder.decode(APIError.self, from: data)
                                  continuation.resume(throwing: decodedErrorResponse)
                                  return
                              }
                        let datas = try self.decoder.decode(T.self, from: data)
                        continuation.resume(returning: datas)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
            .resume()
        }
        return data
    }

/*
    func load<T>(resource: Resource<T>, withToken token: Bool) -> Single<T> {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let body = request.httpBody {
            do {
                let jsonRequest = try JSONSerialization.jsonObject(with: body, options: [])
                let formattedMsg = """
                > \(request)
                The post parameters are
                📡 \(jsonRequest)
                """
                log.debug("Json:", context: formattedMsg)
            } catch let error {
                log.error(error)
            }
        }
        return Single.create(subscribe: { emitter in
            RxAlamofire.requestData(request)
            //.debug()
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { (response, data) in
                    do {
                        let datas = try self.decoder.decode(T.self, from: data)
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let body = request.httpBody {
                            let jsonRequest = try JSONSerialization.jsonObject(with: body, options: [])
                            let formattedMsg = """
                            > \(request)
                            The post parameters are
                            📡 \(jsonRequest)
                            """
                            log.debug("Json:", context: formattedMsg)
                        }
                        let formattedMsg = """
                        > \(request)
                        📡 \(json)
                        """
                        log.debug("Json:", context: formattedMsg)
                        emitter(.success(datas))
                    } catch let error {
                        emitter(.failure(APIErrors.seralizationError(error: error)))
                        log.warning( """
                            Cannot serialize JSON
                            > \(request)
                            📡 \(error)
                            """)
                    }
                }, onError: { (error) in
                    log.error("Error: \(request)", context: error)
                    emitter(.failure(APIErrors.seralizationError(error: error)))
                }).disposed(by: self.disposeBag)
            return Disposables.create()
        })
    }
 */
}
