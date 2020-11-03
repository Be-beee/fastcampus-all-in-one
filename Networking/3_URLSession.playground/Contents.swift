import UIKit

// MARK: - URLSession

// 1. URLSessionConfiguration
// 2. URLSession
// 3. URLSessionTask를 통해 서버와 네트워킹

// URLSessionTask

// - dataTask
// - uploadTask
// - downloadTask


let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)

// URL
// URL Components
var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")!
let mediaQuery = URLQueryItem(name: "media", value: "music")
let entityQuery = URLQueryItem(name: "entity", value: "song")
let termQuery = URLQueryItem(name: "term", value: "Zedd")

urlComponents.queryItems?.append(mediaQuery)
urlComponents.queryItems?.append(entityQuery)
urlComponents.queryItems?.append(termQuery)

let requestURL = urlComponents.url!

// MARK: - struct

// - Response, Track struct 생성
// - struct의 프로퍼티 이름과 실제 데이터의 키와 맞추기 (Codable 디코딩하게 하기 위해서)
struct Response: Codable {
    let resultCount: Int
    let tracks: [Track]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case tracks = "results"
    }
}

struct Track: Codable {
    let title: String
    let artistName: String
    let thumbnailPath: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case artistName
        case thumbnailPath = "artworkUrl100"
    }
}




// MARK: - URLSessionTask

let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
    guard error == nil else { return }
    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
    let successRange = 200 ..< 300
    guard successRange.contains(statusCode) else {
        // handle response error
        return
    }
    guard let resultData = data else { return }
    let resultString = String(data: resultData, encoding: .utf8)
    
    
    // - 파싱 및 트랙 가져오기 (Decoding)
    do {
        let decoder = JSONDecoder()
        let response = try decoder.decode(Response.self, from: resultData)
        let tracks = response.tracks
        
        // - 트랙리스트 가져오기
        print("tracks count: \(tracks.count) -\(tracks.first?.title),\(tracks.first?.thumbnailPath)")
    } catch let error {
        print("error: \(error.localizedDescription)")
    }
}

dataTask.resume()
