extends Node

var playerBody: CharacterBody2D
var playerDamageZone: Area2D
var playerHitbox: Area2D

var frogDamageZone: Area2D
var frogDamageAmount: int


var playerAlive: bool
var playerWeaponEquip: bool
var damage: int = 20

var keySum: int = 0
