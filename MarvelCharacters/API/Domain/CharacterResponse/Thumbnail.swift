import Foundation

struct Thumbnail: Codable {
	let ext: String?
	let path: String?
	var thumbnailUrl: String?

	private enum CodingKeys: String, CodingKey {
		case path
		case ext = "extension"
	}
}

extension Thumbnail {
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		self.ext = try values.decode(String.self, forKey: .ext)
		self.path = try values.decode(String.self, forKey: .path)
		guard let ext = self.ext, let path = self.path?.replacingOccurrences(of: "http", with: "https") else { return }
		self.thumbnailUrl = "\(path).\(ext)"
	}
}
