//our package... simply put, the directory structure to this file
package com.asgamer.basics1
{
	//list of our imports these are classes we need in order to
	//run our application. 
	import flash.display.MovieClip;
	import flash.display.Stage;
	
	//our Engine class it extends MovieClip
	public class Engine extends MovieClip
	{
		private var numStars:int = 80;
		
		//our constructor function. This runs when an object of 
		//the class is created
		public function Engine()
		{
			//create an object of our ship from the Ship class
			var ourShip:Ship = new Ship(stage);
			//add it to the display list
			stage.addChild(ourShip);
			
			ourShip.x = stage.stageWidth / 2;
			ourShip.y = stage.stageHeight / 2;
			
			for (var i:int = 0; i < numStars; i++)
			{
				stage.addChildAt(new Star(stage), 1);
			}
		}
	}
}