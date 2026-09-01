import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int, body: String)
    case decodingError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return tr(.errInvalidURL)
        case .invalidResponse:
            return tr(.errInvalidResponse)
        case .httpError(let statusCode, let body):
            let message = body.isEmpty ? "No response body" : body
            return "HTTP \(statusCode): \(message)"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        }
    }
}
