//
//  SavedMinecraftServer.swift
//  MCStatus
//
//  Created by Tomer Shemesh on 7/30/23.
//

import Foundation
import SwiftData


public enum ServerType: Codable {
    case Java
    case Bedrock
}

@Model
public class SavedMinecraftServer: Identifiable, Codable {
    public var id = UUID()
    public var name = ""
    public var serverUrl = ""
    public var serverPort = 0
    public var srvServerUrl = ""
    public var srvServerPort = 0
    public var serverIcon = ""
    public var displayOrder = 0
    public var serverType = ServerType.Java
    
    public init(id:UUID, serverType: ServerType, name: String, serverUrl: String, serverPort: Int, srvServerUrl: String = "", srvServerPort: Int = 1, serverIcon: String = "", displayOrder: Int = 0) {
        self.id = id
        self.name = name
        self.serverUrl = serverUrl
        self.serverPort = serverPort
        self.srvServerUrl = srvServerUrl
        self.srvServerPort = srvServerPort
        self.serverIcon = serverIcon
        self.displayOrder = displayOrder
        self.serverType = serverType
    }
    
    
    public enum CodingKeys: CodingKey {
        case id, name, serverUrl, serverPort, srvServerUrl, srvServerPort, serverIcon, displayOrder, serverType
      }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.serverUrl = try container.decode(String.self, forKey: .serverUrl)
        self.serverPort = try container.decode(Int.self, forKey: .serverPort)
        self.srvServerUrl = try container.decode(String.self, forKey: .srvServerUrl)
        self.srvServerPort = try container.decode(Int.self, forKey: .srvServerPort)
        self.serverIcon = try container.decode(String.self, forKey: .serverIcon)
        self.displayOrder = try container.decode(Int.self, forKey: .displayOrder)
        self.serverType = try container.decode(ServerType.self, forKey: .serverType)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(serverUrl, forKey: .serverUrl)
        try container.encode(serverPort, forKey: .serverPort)
        try container.encode(srvServerUrl, forKey: .srvServerUrl)
        try container.encode(srvServerPort, forKey: .srvServerPort)
        try container.encode(serverIcon, forKey: .serverIcon)
        try container.encode(displayOrder, forKey: .displayOrder)
        try container.encode(serverType, forKey: .serverType)
    }
}
