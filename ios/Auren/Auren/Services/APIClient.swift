import Foundation

class APIClient {
    static let shared = APIClient()
    private let baseURL = URL(string: "http://192.168.1.109:8000/")!

    func request<T: Decodable>(endpoint: String, method: String = "GET", body: Encodable? = nil, formBody: [String: String]? = nil, token: String? = nil) async throws -> T {
        var request = URLRequest(url: baseURL.appendingPathComponent(endpoint))
        request.httpMethod = method

        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        if let formBody = formBody {
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            let encoded = formBody
                .map { key, value in "\(key)=\(value)" }
                .joined(separator: "&")
            request.httpBody = encoded.data(using: .utf8)
        }
        else if let body = body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(body)
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse {
            print("Status: \(httpResponse.statusCode)")
        }
        print("Body reçu: \(String(data: data, encoding: .utf8) ?? "nil")")

        let decoder = JSONDecoder()
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            if let date = formatter.date(from: dateString) {
                return date
            }
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Format de date invalide: \(dateString)")
        }

        return try decoder.decode(T.self, from: data)
    }
}
