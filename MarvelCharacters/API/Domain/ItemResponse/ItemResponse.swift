import Foundation

struct ItemResponse: Codable {
	let data: ItemData?
}

struct ItemData: Codable {
	let results: [ItemResult]?
}

struct ItemResult: Codable {
	let thumbnail: Thumbnail?
	let urls: [ItemUrl]?
}

struct ItemUrl: Codable {
	let type: String?
	let url: String?
	var link: String?
	
	private enum CodingKeys: String, CodingKey {
		case type, url
	}
}

extension ItemUrl {
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		self.type = try values.decode(String.self, forKey: .type)
		self.url = try values.decode(String.self, forKey: .url)
		guard let link = self.url?.replacingOccurrences(of: "http", with: "https") else { return }
		self.link = link
	}
}
