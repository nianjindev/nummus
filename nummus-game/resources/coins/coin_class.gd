extends Resource
class_name CoinStats

@export var name: String
@export var coin_texture: Texture2D
@export var coin_stats: Dictionary[String, Dictionary] # TRY: predefining on_heads and on_tails. may break stuff lol
@export var description: String # Description rule: only write important functions. Stats will be handled by description generator.
@export var effect: GDScript
@export var price: int