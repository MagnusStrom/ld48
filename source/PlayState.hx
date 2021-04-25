package;

import FlickerinBgIdk.Flicker;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.ui.Mouse;

class PlayState extends FlxState
{
	public static var level = 1;

	public static var lastlevel:Int = 1;

	var FUNNYTEXT:FlxTypeText;

	var MOUSEBOXIGUESS:FlxSprite;
	var CAFFINE:FlxSprite;
	var SWITCH:FlxSprite;

	// OH NO
	var doneTasks:Bool = false;

	override public function create()
	{
		// HITBOXES(TEMPORARILY)
		CAFFINE = new FlxSprite(138, 227).makeGraphic(100, 100, FlxColor.BLACK);
		add(CAFFINE);

		var ship = new FlxSprite(0, 0);
		ship.frames = FlxAtlasFrames.fromSparrow("assets/images/FLICKER.png", "assets/images/FLICKER.xml");
		ship.animation.addByPrefix("idle", "Symbol", 10, true);
		ship.animation.play("idle"); // MIGHT MAKE THIS RANDOM LATER
		add(ship);
		ship.setGraphicSize(670);
		ship.screenCenter();
		ship.antialiasing = true;
		var TEXTBG:FlxSprite = new FlxSprite(0, 350).makeGraphic(700, 500, FlxColor.BLACK);
		add(TEXTBG);
		FUNNYTEXT = new FlxTypeText(10, 350, 630,
			"Day 1 of being on this ship. The UNITED STATES government brought me on this mission. They told me to search for something bright on the ocean floor, but not anything else, so I guess I'll know when I'll find it?.",
			20);
		add(FUNNYTEXT);
		FUNNYTEXT.start(0.03, false, false);

		MOUSEBOXIGUESS = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y).makeGraphic(50, 50, FlxColor.GRAY);
		add(MOUSEBOXIGUESS);

		SWITCH = new FlxSprite(300, 200).makeGraphic(50, 50, FlxColor.BLACK);
		add(SWITCH);

		super.create();
	}

	function loadLevel(levelid)
	{
		// FADE IN
		switch (levelid)
		{
			case 2:
				FUNNYTEXT.resetText("Another amazing day! I wish I had more to do, but I still like just relaxing and watching the ocean go by.");
				FUNNYTEXT.start(0.03, false, false);
		}
		FlxG.camera.fade(FlxColor.WHITE, 2, true, function()
		{
			// RESET SHIT
			CAFFINE.x = 138;
			CAFFINE.y = 227;
			SWITCH.x = 300;
			SWITCH.y = 200;
			// SAY SHIT GET INSANE ON 6 OR SMTN IDK
		});
	}

	override public function update(elapsed:Float)
	{
		MOUSEBOXIGUESS.x = FlxG.mouse.x - 25;
		MOUSEBOXIGUESS.y = FlxG.mouse.y - 25;
		// collisions ig idk whatever thatis
		if (FlxG.overlap(MOUSEBOXIGUESS, CAFFINE) && FlxG.mouse.pressed)
		{
			CAFFINE.x = CAFFINE.y = 1000; // IM LAZY LOOOL
			switch (level)
			{
				case 1:
					FUNNYTEXT.resetText("Oh, forgot my coffee! Always good to wake up in the morning to the ocean and a good cup of coffee.");
					FUNNYTEXT.start(0.03, false, false);
					// GIVING THE PLAYER A FUCKING HIT LMFAOOOOOOO
					new FlxTimer().start(5, function(tmr:FlxTimer)
					{
						if (!doneTasks)
						{
							FUNNYTEXT.resetText("Time to do my tasks! It's as simple as flipping the black switches to yellow to keep the ship alive, as I've been told.");
							FUNNYTEXT.start(0.03, false, false);
						}
					});
				case 2:
					FUNNYTEXT.resetText("Day 2 of coffee! Planning to make this a tradition now. It's very calming, although I wished I had something to read. Time to do my tasks.");
			}
			FUNNYTEXT.start(0.03, false, false);
			// N IF HASNT DONT CHORES GET PISSED. GOD DAMN THIS IS SUCH BAD FRAMEWORK IM SOBBING. I BETTER GET MY SHIT TOGETHER LMFAOOOOOO
		}

		if (FlxG.overlap(MOUSEBOXIGUESS, SWITCH) && FlxG.mouse.pressed)
		{
			doneTasks = true;
			SWITCH.x = SWITCH.y = 1000; // IM LAZY LOOOL
			var sound:FlxSound = new FlxSound().loadEmbedded("assets/sounds/click.ogg", false, true);
			sound.volume = 0.3;
			sound.play();
			switch (level)
			{
				case 1:
					FUNNYTEXT.resetText("And, there we go! Switches keep the submarine alive. I guess im done for the day, heheh.");
					FUNNYTEXT.start(0.03, false, false);
					new FlxTimer().start(5, function(tmr:FlxTimer)
					{
						FUNNYTEXT.resetText("I wonder what to do now... I guess I'll lie down.");
						FUNNYTEXT.start(0.03, false, false);
						new FlxTimer().start(5, function(tmr:FlxTimer)
						{
							FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
							{
								level++;
							});
						});
					});
				case 2:
					FUNNYTEXT.resetText("Done! It doesn't seem important, but I like to think this keeps the submarine alive.");
			}
		}
		// trace(FlxG.mouse.x + ", " + FlxG.mouse.y);
		// funny
		if (lastlevel != level)
		{
			loadLevel(level);
			lastlevel = level;
		}
		else
		{
			lastlevel = level;
		}
		super.update(elapsed);
	}
}
