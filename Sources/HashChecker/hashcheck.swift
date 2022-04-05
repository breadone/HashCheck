import Foundation
import CryptoKit
import ArgumentParser

@available(macOS 10.15, *)
@main
struct hashcheck: ParsableCommand {
    @Argument(help: "Path to the file to check the hash for")
    var file: String
    
    @Argument(help: "The hash to compare against")
    var hash: String
    
    
    func run() throws {
        let fileData = try Data(contentsOf: URL(string: "file://\(file)")!)  // read file into data
        let hashData = hash.data(using: .utf8)!
        
        let fileDigest = SHA256.hash(data: fileData)
        let hashDigest = SHA256.hash(data: hashData)
        
        if fileDigest == hashDigest {
            print("Success! Both hashes match!")
        } else {
            print("Fail! Hashes did not match...")
        }
    }
    
}
