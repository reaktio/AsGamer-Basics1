

package com.asgamer.basics1
{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import com.senocular.utils.KeyObject;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Ship extends MovieClip
	{
		
		private var stageRef:Stage;
		private var key:KeyObject;
		private var speed:Number = 0.5;
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var friction:Number = 0.93;
		private var maxspeed:Number = 8;
		
		//fire related variables
		private var fireTimer:Timer; //causes delay between fires
		private var canFire:Boolean = true; //can you fire a laser
		
		public function Ship(stageRef:Stage)
		{
			this.stageRef = stageRef;
			key = new KeyObject(stageRef);
			
			//setup your fireTimer and attach a listener to it.
			fireTimer = new Timer(300, 1);
			fireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler, false, 0, true);
			
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		public function takeHit() : void
		{
			dispatchEvent(new Event("hit"));
		}
		
		public function loop(e:Event) : void
		{
			//keypresses
			if (key.isDown(Keyboard.LEFT))
				vx -= speed;
			else if (key.isDown(Keyboard.RIGHT))
				vx += speed;
			else
				vx *= friction;
			
			if (key.isDown(Keyboard.UP))
				vy -= speed;
			else if (key.isDown(Keyboard.DOWN))
				vy += speed;
			else
				vy *= friction;
			
			if (key.isDown(Keyboard.SPACE))
				fireBullet();
			
			//update position
			x += vx;
			y += vy;
			
			//speed adjustment
			if (vx > maxspeed)
				vx = maxspeed;
			else if (vx < -maxspeed)
				vx = -maxspeed;
			
			if (vy > maxspeed)
				vy = maxspeed;
			else if (vy < -maxspeed)
				vy = -maxspeed;
			
			//ship appearance
			rotation = vx;
			scaleX = (maxspeed - Math.abs(vx))/(maxspeed*4) + 0.75;
			
			//stay inside screen
			if (x > stageRef.stageWidth)
			{
				x = stageRef.stageWidth;
				vx = -vx;
			}
			else if (x < 0)
			{
				x = 0;
				vx = -vx;
			}
			
			if (y > stageRef.stageHeight)
			{
				y = stageRef.stageHeight;
				vy = -vy;
			}
			else if (y < 0)
			{
				y = 0;
				vy = -vy;
			}
			
		}
		
		private function fireBullet() : void
		{
			//if canFire is true, fire a bullet
			//set canFire to false and start our timer
			//else do nothing.
			if (canFire)
			{
				stageRef.addChild(new LaserBlue(stageRef, x + vx, y - 10));
				canFire = false;
				fireTimer.start();
			}
			
		}
		
		//HANDLERS
		
		private function fireTimerHandler(e:TimerEvent) : void
		{
			//timer ran, we can fire again.
			canFire = true;
		}
		
	}
	
}

