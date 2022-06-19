import Foundation
import Combine

struct NetworkResponse<Wrapped: Decodable>: Decodable {
    var result: Wrapped
    var test: Bool = false
}

extension URLSession {
    @available(macOS 10.15, *)
    func customPublisher <T: Decodable>(
        for url: URL,
        responseType: T.Type = T.self,
        decoder: JSONDecoder = .init()
    ) -> AnyPublisher<T,Error> {
        dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NetworkResponse<T>.self, decoder: decoder)
            .map(\.result)
            .eraseToAnyPublisher()
    }

}
