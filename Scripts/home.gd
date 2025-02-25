extends Control


onready var settings = get_node("SettingsMenu") #Conexion al SettingsMenu(PopMenu)
onready var audio_stream_player = $AudioStreamPlayer

onready var pet = $Pet
onready var confirmation_layer_ref = $Confirmation
onready var aliasShow = $Alias/name
onready var pointShow = $Point/value


var connection = null
var quser = null

func _ready():

	#connect("volume_changed", self, "_on_volume_changed")
	aliasShow.bbcode_text = "Multiplos" #[color=#CACFD2]" + str(globalVar.ALIAS)
	pointShow.bbcode_text = "[color=#CACFD2]" + str(globalVar.points)
	pet.starPet()
	#OpenConnectionDatabase()
	settings.connect("volume_changed", self, "_on_volume_changed")
	


#Control de Audio por BUS	
func _on_volume_changed(bus_idx, volume):
		match bus_idx:
			0:
				audio_stream_player.set_bus_volume_db(0, volume)
			1:
				audio_stream_player.set_bus_volume_db(1, volume)
			2:
				audio_stream_player.set_bus_volume_db(2, volume)
			
#func _on_volume_changed(value):
#	audio_stream_player.volume_db = value

func _on_Bttn_Play_pressed():
	#pet.starPetHappy()

	#yield(get_tree().create_timer(1.4), "timeout")

	
	# START GAME LEVEL
	get_tree().change_scene("res://Scenes/niveles/niveles.tscn") 

func _on_Bttn_Option_pressed():
	$SettingsMenu.popup()
	

func _on_Bttn_Exit_pressed():
	confirmation_layer_ref.visible = true
	confirmation_layer_ref.connect("choice_made", self, "_on_confirmation_choice")
	pet.visible = false
	$Confirmation.visible = true

func _on_confirmation_choice(choice):
	if choice == "confirm":
		pet.stopPet()
#		ckeckData()
		yield(get_tree().create_timer(0.3), "timeout")
		
		#Agregar confirmacion de guardado 
		
		get_tree().quit()
		
	elif choice == "cancel":
		pet.visible = true
		pet.starPet()
		


# ACTUALIZA DATOS DEL USUARIO INGRESADO
#======================================
#func OpenConnectionDatabase():
#	connection = DBConnection.new()
#	connection.openConnection()
	


#func getInformation() -> void :
#	quser = Quser.new() 
#	var fk = globalVar.idUSER
#	var result = quser.inventoryAll(fk)
	
	var totalPoints = 0
	var totalCoins = 0
	#var itemsList = []
	
#	for i in range(result.size()):
#		totalPoints +=  result[i]['points']
#		totalCoins += result[i]['coin']
		#itemsList += result[i]['idItems']
		
	globalVar.obtainedPoint = totalPoints
	globalVar.obtainedCoin  = totalCoins
	globalVar.points = totalPoints
	globalVar.coins  = totalCoins



func ckeckData():
	quser = Quser.new() 

	var point = globalVar.points - globalVar.obtainedPoint
	var coin = globalVar.coins - globalVar.obtainedCoin
	var item = "item1"
	var idUser = globalVar.idUSER

	if((point == 0) and (coin == 0)) :
		pass
	else :
		quser.saveInventory(point,coin,item,idUser)

# =================================================
