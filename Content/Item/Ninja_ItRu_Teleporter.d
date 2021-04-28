instance Ninja_ItRu_Teleporter(C_Item)
{
	name 		=	"Teleport zur letzten Position"; //Name Item in world (Focus Vob)

	mainflag 	=	ITEM_KAT_RUNE; //Categorie of Item
	flags 		=	0;

	value 		=	0; //Currency Cost

	visual 		=	"Ninja_ItRu_Teleporter.3ds"; //Model of Item in world and inventory	
	material 	=	MAT_STONE; //Material Sound??
	
	scemeName	=	"MAPSEALED"; 
	on_state[0]	=	OwnTeleports_startDialog; //Call Script
	
	effect		=	"SPELLFX_WEAKGLIMMER"; //Fx effect on Item in world
	
	description	= 	"Teleport zur letzten Position"; //Desciption of Item for the Player
	
	TEXT	[1]			=	"Manakosten"; //Text left top			
	COUNT	[1]			=	40; //Value Text right top
};
