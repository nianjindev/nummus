extends Resource
class_name CoinStats

@export var name: String
@export var coin_texture: Texture2D
@export var coin_stats: Dictionary[String, int]
@export var description: String # Description rule: only write important functions. Stats will be handled.
@export var effect: GDScript
