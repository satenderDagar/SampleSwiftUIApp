import XCTest
@testable import Networking

final class NetworkServiceTests: XCTestCase {
    
    let sampleData =
    """
     [{
        "name": "Aave"
      }]
    """.data(using: .utf8)!
    
    func setupMockResponse(with url: URL, statusCode: Int = 200, sampleData: Data?, error: Error?) -> mockResponseCompletion {
        let mockResponse: mockResponseCompletion = {
            let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
            return (sampleData, response, error)
        }()
        return mockResponse
    }
    
    func setupMockUrlSession(for url:URL, response: mockResponseCompletion) -> URLSession {
        URLProtocolMock.mockResponses = [url: response]
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: config)
    }
    
    func testSuccessfullFetchingData() async throws {
        let url = try XCTUnwrap(URL(string: "https://fake-json-api.mock.beeceptor.com/users"))
        let mockResponse = setupMockResponse(with: url, sampleData: sampleData, error: nil)
        let mockedSession = setupMockUrlSession(for: url, response: mockResponse)
        
        let sut = NetworkService(session: mockedSession)
        
        let data = try await sut.fetchData(from: url)
        
        XCTAssertEqual(data, sampleData)
    }
    
    func testFailureFetchingData() async throws {
        let url = try XCTUnwrap(URL(string: "https://fake-json-api.mock.beeceptor.com/users"))
        let mockResponse = setupMockResponse(with: url, statusCode: 400, sampleData: nil, error: nil)
        let mockedSession = setupMockUrlSession(for: url, response: mockResponse)
        
        let sut = NetworkService(session: mockedSession)
        
        var data: Data? = nil
        do {
            data = try await sut.fetchData(from: url)
        } catch let error as NetworkError {
            XCTAssertEqual(error, .invalidResponse)
        }
        
        XCTAssertNil(data)
    }
}


