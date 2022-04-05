import XCTest
import class Foundation.Bundle
import CommonCrypto
import CryptoKit

final class HashChecks: XCTestCase {
    func testSHA256() throws {
        let file = "/Users/pradyun/Documents/SCCommands.json"
        let length = Int(CC_SHA256_DIGEST_LENGTH)
        
        let fileData = try Data(contentsOf: URL(string: "file://\(file)")!)
        let digest = UnsafeMutablePointer<UInt8>.allocate(capacity: length)
        defer { digest.deallocate() }
        
        fileData.withUnsafeBytes { (buffer) -> Void in
            CC_SHA256(buffer.baseAddress!, CC_LONG(buffer.count), digest)
        }
        
        print("HASH: ", String(data: Data(bytes: digest, count: length), encoding: .utf8) ?? "nop")
    }
    
    func testCryptoKitSHA256() {
        let file = "/Users/pradyun/Documents/SCCommands.json"
        let fileData = try! Data(contentsOf: URL(string: "file://\(file)")!)
        
        print(SHA256.hash(data: fileData))
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }
}
