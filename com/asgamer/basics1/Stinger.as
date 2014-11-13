

package com.asgamer.basics1
{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class Stinger extends MovieClip
	{
		
		private var stageRef:Stage;
		private var vy:Number = 4;
		private var ay:Number = .2;
		private var target:Ship;
		
		public var points:int = 1020; //the points for killing this enemy
		
		public function Stinger(stageRef:Stage, target:Ship) : void
		{
			stop();
			this.stageRef = stageRef;
			this.target = target;
			
			x = Math.random() * stageRef.stageWidth;
			y = -5;
			
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		private function loop(e:Event) : void
		{
			if (currentLabel != "destroyed")
			{
				vy += ay;
				y += vy;
				
				if (y &gt; stageRef.stageHeight)
					removeSelf();
				
				if (y - 15 &lt; target.y &amp;&amp; y + 15 &gt; target.y)
					fireWeapon();
			}
			
			if (currentLabel == "destroyedComplete")
				removeSelf();
		}
		
		private function fireWeapon() : void
		{
			stageRef.addChild(new StingerBullet(stageRef, target, x, y, -8));
			stageRef.addChild(new StingerBullet(stageRef, target, x, y, 8));
		}
		
		private function removeSelf() : void {
			
			removeEventListener(Event.ENTER_FRAME, loop);
			
			if (stageRef.contains(this))
				stageRef.removeChild(this);
			
		}
		
		public function takeHit() : void
		{
			if (currentLabel != "destroyed") //insure we can't keep killing the enemy ship... over and over
			{
				dispatchEvent(new Event("killed")); //our new ship killed event
				rotation = Math.random() * 360;
				gotoAndPlay("destroyed");
			}
		}
		
	}
	
}


