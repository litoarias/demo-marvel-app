import Foundation

struct Character: Codable {
	let comics: Comic?
	let desc: String?
	let events: Comic?
	let identifier: Int?
	let modified: String?
	let name: String?
	let resourceURI: String?
	let series: Comic?
	let stories: Comic?
	let thumbnail: Thumbnail?
	let urls: [ChracterUrl]?
	var descript: String?
	
	private enum CodingKeys: String, CodingKey {
		case comics, events, modified, name, resourceURI, series, stories, thumbnail, urls
		case identifier = "id"
		case desc = "description"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.comics = try container.decode(Comic.self, forKey: .comics)
		self.desc = try container.decode(String.self, forKey: .desc)
		self.descript = self.desc?.isEmpty ?? "".isEmpty ? "Not description provided": self.desc
		self.events = try container.decode(Comic.self, forKey: .events)
		self.identifier = try container.decode(Int.self, forKey: .identifier)
		self.modified = try container.decode(String.self, forKey: .modified)
		self.name = try container.decode(String.self, forKey: .name)
		self.resourceURI = try container.decode(String.self, forKey: .resourceURI)
		self.series = try container.decode(Comic.self, forKey: .series)
		self.stories = try container.decode(Comic.self, forKey: .stories)
		self.thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)
		self.urls = try container.decode([ChracterUrl].self, forKey: .urls)
	}
}
