extends Node


var coins = 0
var playerMaxHealth = 10
var playerCurrentHealth = 10
var currentXp = 0
var maxXP = 10
var currentLevel = 1
var minDamage = 2
var maxDamage = 3
var maxHunger = 100
var hunger = 100
var critChance = 0.1
func _process(_delta):
	if currentXp >= maxXP:
		level_up()
	if hunger < 0:
		hunger = 0
	if hunger > maxHunger:
		hunger = maxHunger
	
func level_up():
	minDamage = round(minDamage * 1.4)
	maxDamage = round(maxDamage * 1.4)
	if currentLevel % 2 == 0:
		critChance += 0.1
	playerMaxHealth += 5
	playerCurrentHealth = playerMaxHealth
	currentXp = currentXp - maxXP 
	maxXP *= 2
	currentLevel += 1
	hunger = 100
	
