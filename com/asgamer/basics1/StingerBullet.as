

package com.asgamer.basics1
{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class StingerBullet extends MovieClip
	{
		
		private var stageRef:Stage;
		private var target:Ship;
		
		private var vx:Number;
		
		public function StingerBullet(stageRef:Stage, target:Ship, x:Number, y:Number, vx:Number) : void
		{
			this.stageRef = stageRef;
			this.target = target;
			this.x = x;
			this.y = y;
			this.vx = vx;
			
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		private function loop(e:Event) : void
		{
			x += vx;
			
			if (x &gt; stageRef.stageWidth || x &lt; 0)
				removeSelf();
			
			if (hitTestObject(target.hit))
			{
				target.takeHit();
				stageRef.addChild(new SmallImplosion(stageRef, x, y));
				removeSelf();
			}
		}
		
		private function removeSelf() : void
		{
			removeEventListener(Event.ENTER_FRAME, loop);
			if (stageRef.contains(this))
				stageRef.removeChild(this);
		}
		
	}
	
}

