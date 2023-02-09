//
//  HTTPClient.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/8/23.
//

import Foundation

protocol HTTPClient {
    var session: CustomSession { get }

    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        guard let url = URL(string: endpoint.path)
        else { return .failure(.invalidURL) }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)

        request.httpMethod = endpoint.method.rawValue

        do {
            let (data, response) = try await session.data(for: request, delegate: nil)

            guard let response = response as? HTTPURLResponse,
                  let url = response.url
            else {
                return .failure(.noResponse)
            }

            switch response.statusCode {
                case 200 ... 299:
                    guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                        debugPrint("˒ ✅ \(url): \(response.statusCode)")
                        debugPrint("˒ ⛔️ \(url): \(String(describing: String(data: data, encoding: .utf8)))")
                        return .failure(.decode)
                    }

                    return .success(decodedResponse)

                case 401:
                    return .failure(.unauthorized)

                default:
                    return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown(error))
        }
    }
}
