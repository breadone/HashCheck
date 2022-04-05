import Foundation
import ArgumentParser

@main
struct hashcheck: ParsableCommand {
    @Argument var file: String
    @Argument var hash: String
    
    @Option(help: "If you only want to compare a specific type of hash: md5, sha256")  // more to come
    var type: Hashtype
    
    func run() throws {
        // to come
    }
    
}

public enum Hashtype: ExpressibleByArgument {
    
    public init?(argument: String) {
        switch argument {
        case "md5":
            self = .md5
            
        case "sha256":
            self = .sha256
            
        default:  // break
            self = .unknown
        }
    }
    
    case md5, sha256
    case unknown
}
