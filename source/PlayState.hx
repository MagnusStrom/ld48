package;

import WiggleEffect.WiggleEffectType;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.events.FullScreenEvent;
import openfl.filters.ColorMatrixFilter;
import openfl.filters.GlowFilter;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.ui.Mouse;

class PlayState extends FlxState
{
	public static var level = 1;

	public static var lastlevel:Int = 1;

	var FUNNYTEXT:FlxTypeText;

	var MOUSEBOXIGUESS:FlxSprite;
	var CAFFINE:FlxSprite;
	var DAYS:FlxSprite;
	var OXY:FlxSprite;

	var funnybg:FlxBackdrop;
	// OH NO
	var doneTasks:Bool = false;

	var SWITCHGUI1:Switch;
	var SWITCHGUI2:Switch;
	var SWITCHGUI3:Switch;

	var screen:FlxSprite;

	public var depth = 10;

	var high:Bool = false;

	var drankCoffee:Bool = false;

	var wiggleShit:WiggleEffect = new WiggleEffect();

	var ship:FlxSprite;
	var highShitLOL:FlxEffectSprite;

	var DESCTEXT:FlxText;

	var funnyframe:FlxSprite;
	var notsofunnyframe:FlxSprite;
	var badBoiScene:Bool = false;

	var inCutscene:Bool = false; // JUST FOR UHH FUCKIN WAKING UP N SHIT

	override public function create()
	{
		FlxG.debugger.drawDebug = true;

		FlxG.fixedTimestep = false;
		// HITBOXES(TEMPORARILY)

		DAYS = new FlxSprite(453, 40).makeGraphic(150, 150, FlxColor.BLACK);
		add(DAYS);

		OXY = new FlxSprite(149, 32).makeGraphic(150, 150, FlxColor.BLACK);
		add(OXY);

		funnybg = new FlxBackdrop("assets/images/TSUISJESUS.png", 0, 3, true, true);
		add(funnybg);
		funnybg.velocity.y = -100;

		ship = new FlxSprite(0, 0);
		//	ship.loadGraphic('assets/images/NOFLICKERTROLLFACE.png');
		ship.frames = FlxAtlasFrames.fromSparrow("assets/images/FLICKER.png", "assets/images/FLICKER.xml");
		ship.animation.addByPrefix("idle", "Symbol", 8, true);
		ship.animation.play("idle"); // MIGHT MAKE THIS RANDOM LATER
		add(ship);
		ship.setGraphicSize(670);
		ship.screenCenter();
		ship.antialiasing = true;

		var wave:FlxWaveEffect = new FlxWaveEffect(FlxWaveMode.ALL, 5, 0.5, 1, 10, FlxWaveDirection.HORIZONTAL);

		highShitLOL = new FlxEffectSprite(ship, [wave]);
		// highShitLOL.setGraphicSize(1000); // 670
		// highShitLOL.screenCenter();
		highShitLOL.scale.set(0.7, 0.7);
		highShitLOL.x -= 150;
		highShitLOL.y -= 110;
		add(highShitLOL);
		highShitLOL.visible = false;

		funnyframe = new FlxSprite(0, 0).loadGraphic("assets/images/THEFUCKINGCUP.png");
		funnyframe.screenCenter();
		add(funnyframe);
		funnyframe.visible = false;

		notsofunnyframe = new FlxSprite(0, 0).loadGraphic("assets/images/itspissing.png");
		notsofunnyframe.screenCenter();
		add(notsofunnyframe);
		notsofunnyframe.visible = false;

		var TEXTBG:FlxSprite = new FlxSprite(0, 350).makeGraphic(700, 500, FlxColor.BLACK);
		add(TEXTBG);
		FUNNYTEXT = new FlxTypeText(10, 350, 630,
			"Day 1 of being on this ship. The UNITED STATES government brought me on this mission. They told me to search for something bright on the ocean floor, but not anything else, so I guess I'll know when I'll find it?.",
			20);
		add(FUNNYTEXT);
		FUNNYTEXT.start(0.03, false, false);

		MOUSEBOXIGUESS = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y).makeGraphic(10, 10, FlxColor.GRAY);
		add(MOUSEBOXIGUESS);
		MOUSEBOXIGUESS.visible = false;

		SWITCHGUI1 = new Switch(400, 210);
		add(SWITCHGUI1);
		SWITCHGUI1.width = 5;
		SWITCHGUI1.height = 5;
		SWITCHGUI1.offset.set(0, 0);
		SWITCHGUI1.updateHitbox();

		SWITCHGUI2 = new Switch(200, 200);
		add(SWITCHGUI2);
		SWITCHGUI2.flipX = true;
		SWITCHGUI2.width = 5;
		SWITCHGUI2.height = 5;
		SWITCHGUI2.offset.set(0, 0);
		SWITCHGUI2.updateHitbox();

		SWITCHGUI3 = new Switch(300, 200);
		add(SWITCHGUI3);
		SWITCHGUI3.width = 5;
		SWITCHGUI3.height = 5;
		SWITCHGUI3.offset.set(0, 0);
		SWITCHGUI3.updateHitbox();

		DESCTEXT = new FlxText(FlxG.mouse.x, FlxG.mouse.y, 1000, "", 12);
		add(DESCTEXT);

		CAFFINE = new FlxSprite(100, 197).makeGraphic(75, 75, FlxColor.BLACK);
		add(CAFFINE);
		CAFFINE.visible = false;

		super.create();
	}

	function loadLevel(levelid)
	{
		drankCoffee = false;
		inCutscene = true;
		// FlxG.random.bool(50)
		// big brain hours(ignore the rest of my code just look at this okokok ty)
		SWITCHGUI1.switchState(false);
		SWITCHGUI2.switchState(false);
		SWITCHGUI3.switchState(false);
		// FADE IN
		switch (levelid)
		{
			case 2:
				FUNNYTEXT.resetText("Another day! I wish I had more to do, but I still like just relaxing and watching the ocean go by.");
				FUNNYTEXT.start(0.03, false, false, null, function()
				{
					inCutscene = false;
				});
			case 3:
				FUNNYTEXT.resetText("Another day, another coffee to drink, another switch to press. Better get to it.");
				FUNNYTEXT.start(0.03, false, false, null, function()
				{
					inCutscene = false;
				});
			case 4:
				FUNNYTEXT.resetText("Good morning to me. Just gotta remember to keep on pressing. I'll make it to the bottom eventually.");
				FUNNYTEXT.start(0.03, false, false, null, function()
				{
					inCutscene = false;
				});
			case 5:
				FUNNYTEXT.resetText("I wish I could change the inside of the ship; the scenery outside is always the same.");
				FUNNYTEXT.start(0.03, false, false, null, function()
				{
					inCutscene = false;
				});
			case 6:
				FUNNYTEXT.resetText("It's been quite a while since I started. I wonder what would happen if I didn't press the switches..?");
				FUNNYTEXT.start(0.03, false, false, null, function()
				{
					inCutscene = false;
				});
			case 7:
				FUNNYTEXT.resetText("I'm starting to lose track of time down here. I'm going to let my curiosity get the best of me. Let's see what happens if I don't press the switches.");
				FUNNYTEXT.start(0.03, false, false, null, function()
				{
					inCutscene = false;
				});
			case 8:
				highShitLOL.visible = true;
				ship.visible = false;
				FUNNYTEXT.resetText("Woah, this feels weird. It feels like my head is floating. I like this.");
				FUNNYTEXT.start(0.03, false, false, null, function()
				{
					inCutscene = false;
				});
			case 9:
				FlxG.camera.color = FlxColor.GRAY;
				FUNNYTEXT.resetText("I....");
				FUNNYTEXT.start(0.03, false, false);
				new FlxTimer().start(3, function(tmr:FlxTimer)
				{
					FUNNYTEXT.resetText("I didin't dream of anything.");
					FUNNYTEXT.start(0.03, false, false);
					new FlxTimer().start(3, function(tmr:FlxTimer)
					{
						FUNNYTEXT.resetText("It was just a gray room.");
						FUNNYTEXT.start(0.03, false, false);
						new FlxTimer().start(3, function(tmr:FlxTimer)
						{
							FUNNYTEXT.resetText("I couldn't move. I couldn't do anything.");
							FUNNYTEXT.start(0.03, false, false);
							new FlxTimer().start(3, function(tmr:FlxTimer)
							{
								FUNNYTEXT.resetText("I was forced to sit there.");
								FUNNYTEXT.start(0.03, false, false);
								new FlxTimer().start(3, function(tmr:FlxTimer)
								{
									FUNNYTEXT.resetText("I need a change. I NEED A CHANGE.");
									FUNNYTEXT.start(0.03, false, false);
									new FlxTimer().start(3, function(tmr:FlxTimer)
									{
										FUNNYTEXT.resetText("Fuck my life...");
										FUNNYTEXT.start(0.03, false, false, null, function()
										{
											inCutscene = false;
										});
									});
								});
							});
						});
					});
				});
		}
		FlxG.camera.fade(FlxColor.WHITE, 1, true, function()
		{
			// RESET SHIT
			doneTasks = false;
			CAFFINE.x = 100;
			CAFFINE.y = 197;
			// SAY SHIT GET INSANE ON 6 OR SMTN IDK
		});
	}

	function checkSwitches()
	{
		if (SWITCHGUI1.on == true && SWITCHGUI2.on == true && SWITCHGUI3.on == true)
		{
			doneTasks = true;
			switch (level)
			{
				case 1:
					FUNNYTEXT.resetText("Switch! Switches keep the submarine alive. I guess im done for the day, heheh.");
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
					FUNNYTEXT.start(0.03, false, false);
					new FlxTimer().start(5, function(tmr:FlxTimer)
					{
						FUNNYTEXT.resetText("You know, I wish I had a book, or something or someone else to observe. But It's fine!");
						FUNNYTEXT.start(0.03, false, false);
						new FlxTimer().start(5, function(tmr:FlxTimer)
						{
							FUNNYTEXT.resetText("I think I'm gonna go to bed. Maybe I'll dream about a book.");
							FUNNYTEXT.start(0.03, false, false);

							new FlxTimer().start(5, function(tmr:FlxTimer)
							{
								FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
								{
									level++;
								});
							});
						});
					});
				case 3:
					FUNNYTEXT.resetText("Nice satisfying presses. Just wish I had something better to do...");
					FUNNYTEXT.start(0.03, false, false);
					new FlxTimer().start(5, function(tmr:FlxTimer)
					{
						FUNNYTEXT.resetText("This is starting to get a little boring.. But I should be okay!");
						FUNNYTEXT.start(0.03, false, false);
						new FlxTimer().start(5, function(tmr:FlxTimer)
						{
							FUNNYTEXT.resetText("We should be at the ocean floor any day now.");
							FUNNYTEXT.start(0.03, false, false);

							new FlxTimer().start(5, function(tmr:FlxTimer)
							{
								FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
								{
									level++;
								});
							});
						});
					});
				case 4:
					FUNNYTEXT.resetText("Alright. I should get some rest, maybe i'll have an interesting dream.");
					FUNNYTEXT.start(0.03, false, false);
					FlxG.camera.fade(FlxColor.BLACK, 7, false, function()
					{
						level++;
					});
				case 5:
					FUNNYTEXT.resetText("Done. Now, to sleep in hopes of waking up somewhere new");
					FUNNYTEXT.start(0.03, false, false);
					FlxG.camera.fade(FlxColor.BLACK, 7, false, function()
					{
						level++;
					});
				case 6:
					FUNNYTEXT.resetText("I'm done for today. Just have to keep on going.");
					FUNNYTEXT.start(0.03, false, false);
					FlxG.camera.fade(FlxColor.BLACK, 7, false, function()
					{
						level++;
					});
				case 7:
					FUNNYTEXT.resetText("No switch presses for today.");
					FUNNYTEXT.start(0.03, false, false);
				case 8:
					FUNNYTEXT.resetText("No switch presses. I like this feeling.");
					FUNNYTEXT.start(0.03, false, false);
				default:
					FUNNYTEXT.resetText("No switch presses.");
					FUNNYTEXT.start(0.03, false, false);
			}
		}
	}

	override public function update(elapsed:Float)
	{
		MOUSEBOXIGUESS.x = DESCTEXT.x = FlxG.mouse.x; //- 25;
		MOUSEBOXIGUESS.y = DESCTEXT.y = FlxG.mouse.y - 15;

		// LOOOOL IM LAZY
		if (inCutscene == false)
		{
			if (FlxG.overlap(MOUSEBOXIGUESS, CAFFINE) && badBoiScene == false)
			{
				DESCTEXT.text = "Coffee: Click to drink";
			}
			else if (FlxG.overlap(MOUSEBOXIGUESS, SWITCHGUI1)
				|| FlxG.overlap(MOUSEBOXIGUESS, SWITCHGUI2)
				|| FlxG.overlap(MOUSEBOXIGUESS, SWITCHGUI3))
			{
				if (level < 9)
				{
					if (drankCoffee == true)
					{
						DESCTEXT.text = "Switch: Click to flip";
					}
					else
					{
						DESCTEXT.text = "Drink Coffee First!";
					}
				}
			}
			else if (badBoiScene == true)
			{
				DESCTEXT.text = "Coffee: Click to drink";
			}
			else
			{
				DESCTEXT.text = "";
			}
		}
		else
		{
			DESCTEXT.text = "Wait...";
		}
		if (badBoiScene == true && FlxG.mouse.pressed)
		{
			badBoiScene = false;
			var CUTTINGREALLOL:FlxSprite = new FlxSprite(0, 0).makeGraphic(1000, 1000, FlxColor.BLACK);
			add(CUTTINGREALLOL);
			var sound:FlxSound = new FlxSound().loadEmbedded("assets/sounds/TSUSIPREAL.mp3", false, true);
			sound.volume = 0.5;
			sound.play();
			new FlxTimer().start(5, function(tmr:FlxTimer)
			{
				var sound:FlxSound = new FlxSound().loadEmbedded("assets/sounds/hacking.mp3", false, true);
				sound.volume = 0.5;
				sound.play();
				new FlxTimer().start(3, function(tmr:FlxTimer)
				{
					FlxG.switchState(new CreditsState());
				});
			});
		}
		// SWITCH COLLISIONS
		// (FlxG.overlap(MOUSEBOXIGUESS, SWITCH) // collisions ig idk whatever thatis
		if (FlxG.overlap(MOUSEBOXIGUESS, OXY) && FlxG.mouse.pressed && doneTasks == false)
		{
			OXY.x = 1000;
			OXY.y = 1000;
			switch (level)
			{
				case 1:
					FUNNYTEXT.resetText("This shows the amount of oxygen in the ship. Should never go down, aslong as I keep flipping the switches!");
					FUNNYTEXT.start(0.03, false, false);
				default:
			}
		}

		if (FlxG.overlap(MOUSEBOXIGUESS, CAFFINE)
			&& FlxG.mouse.pressed
			&& doneTasks == false
			&& badBoiScene == false
			&& inCutscene == false)
		{
			drankCoffee = true;
			CAFFINE.x = CAFFINE.y = 1000; // IM LAZY LOOOL
			if (level < 9)
			{
				var sound:FlxSound = new FlxSound().loadEmbedded("assets/sounds/TSUSIPREAL.mp3", false, true);
				sound.volume = 0.2;
				sound.play();
			}
			inCutscene = true;
			switch (level)
			{
				case 1:
					FUNNYTEXT.resetText("Ah yes, a warm cup of coffee! Always good to wake up in the morning to the ocean and a good cup of coffee.");
					FUNNYTEXT.start(0.03, false, false);
					new FlxTimer().start(5, function(tmr:FlxTimer)
					{
						FUNNYTEXT.resetText("Time to do my tasks! It's as simple as flipping the black switches to yellow to keep the ship alive, as I've been told.");
						FUNNYTEXT.start(0.03, false, false, null, function()
						{
							inCutscene = false;
						});
					}); // big lazy
				case 2:
					FUNNYTEXT.resetText("Day 2 of coffee! Planning to make this a tradition now. It's very calming, although I wished I had something to read. Time to do my tasks.");
				case 3:
					FUNNYTEXT.resetText("I wish my coffee was warmer.");
				case 4:
					FUNNYTEXT.resetText("Even this is getting a little repetitive, but the energy boost is well needed. Back to pressing.");
				case 5:
					FUNNYTEXT.resetText("I feel a little better. Now, to press those switches.");
				case 6:
					FUNNYTEXT.resetText("That coffee always gets me in the working mood.");
				case 7:
					FUNNYTEXT.resetText("The effects of this coffee are getting duller.");
					FUNNYTEXT.start(0.03, false, false);
					new FlxTimer().start(5, function(tmr:FlxTimer)
					{
						FUNNYTEXT.resetText("Now I just, chill, I guess.");
						FUNNYTEXT.start(0.03, false, false);
						new FlxTimer().start(9, function(tmr:FlxTimer)
						{
							FUNNYTEXT.resetText("Wow, there really is nothing to do in here.");
							FUNNYTEXT.start(0.03, false, false);
							new FlxTimer().start(5, function(tmr:FlxTimer)
							{
								FUNNYTEXT.resetText("The background is so repetitive...");
								FUNNYTEXT.start(0.03, false, false);
								new FlxTimer().start(7, function(tmr:FlxTimer)
								{
									FUNNYTEXT.resetText("I suppose i'm done for the night. I don't feel a change right now, but I'll see what happens tomorrow, I guess.");
									FUNNYTEXT.start(0.03, false, false);
									new FlxTimer().start(6, function(tmr:FlxTimer)
									{
										FlxG.camera.fade(FlxColor.BLACK, 7, false, function()
										{
											level++;
										});
									});
								});
							});
						});
					});
				case 8:
					FUNNYTEXT.resetText("This coffee feels dry. Must be the oxygen.");
					FUNNYTEXT.start(0.03, false, false);
					new FlxTimer().start(5, function(tmr:FlxTimer)
					{
						FUNNYTEXT.resetText("Huh, for some reason I'm tired early.");
						FUNNYTEXT.start(0.03, false, false);
						new FlxTimer().start(5, function(tmr:FlxTimer)
						{
							FUNNYTEXT.resetText("I'm gonna go to bed... To wonderful dreams.");
							FUNNYTEXT.start(0.03, false, false);
							FlxG.camera.fade(FlxColor.BLACK, 5, false, function()
							{
								level++;
							});
						});
					});
				default:
					SWITCHGUI1.visible = false;
					SWITCHGUI2.visible = false;
					SWITCHGUI3.visible = false;
					// SHOW FRAME HERE?
					// YES
					funnyframe.visible = true;
					FUNNYTEXT.resetText("This....");
					FUNNYTEXT.start(0.03, false, false);
					new FlxTimer().start(3, function(tmr:FlxTimer)
					{
						FUNNYTEXT.resetText("This coffee is the same.");
						FUNNYTEXT.start(0.03, false, false);
						new FlxTimer().start(3, function(tmr:FlxTimer)
						{
							FUNNYTEXT.resetText("It's the same thing. Day after day after day.");
							FUNNYTEXT.start(0.03, false, false);
							new FlxTimer().start(3, function(tmr:FlxTimer)
							{
								FUNNYTEXT.resetText("I have to drink something else.");
								FUNNYTEXT.start(0.03, false, false);
								new FlxTimer().start(3, function(tmr:FlxTimer)
								{
									FUNNYTEXT.resetText("Something, something that would wake me up... for real.");
									FUNNYTEXT.start(0.03, false, false);
									new FlxTimer().start(3, function(tmr:FlxTimer)
									{
										FUNNYTEXT.resetText("Maybe the taste of blood...");
										FUNNYTEXT.start(0.03, false, false);
										new FlxTimer().start(5, function(tmr:FlxTimer)
										{
											var CUTTINGREALLOL:FlxSprite = new FlxSprite(0, 0).makeGraphic(1000, 1000, FlxColor.BLACK);
											add(CUTTINGREALLOL);
											var sound:FlxSound = new FlxSound().loadEmbedded("assets/sounds/heavybreathing.mp3", false, true);
											sound.volume = 0.5;
											sound.play();
											trace("Breathe");
											new FlxTimer().start(1, function(tmr:FlxTimer)
											{
												var sound:FlxSound = new FlxSound().loadEmbedded("assets/sounds/slit.mp3", false, true);
												sound.volume = 1;
												sound.play();
												new FlxTimer().start(1, function(tmr:FlxTimer)
												{
													var sound:FlxSound = new FlxSound().loadEmbedded("assets/sounds/slit.mp3", false, true);
													sound.volume = 1;
													sound.play();
													new FlxTimer().start(1, function(tmr:FlxTimer)
													{
														var sound:FlxSound = new FlxSound().loadEmbedded("assets/sounds/slit.mp3", false, true);
														sound.volume = 0.5;
														sound.play();
													});
												});
											});
											new FlxTimer().start(5, function(tmr:FlxTimer)
											{
												trace("scream");
												// SCREAM
												// pp
												new FlxTimer().start(5, function(tmr:FlxTimer)
												{
													badBoiScene = true;
													funnyframe.visible = false;
													notsofunnyframe.visible = true;
													trace("Back");
													FlxG.camera.color = FlxColor.WHITE;
													FUNNYTEXT.resetText("...");
													FUNNYTEXT.start(0.03, false, false);

													ship.frames = FlxAtlasFrames.fromSparrow("assets/images/SHIPINSANE.png", "assets/images/SHIPINSANE.xml");
													CUTTINGREALLOL.visible = false;
												});
											});
										});
									});
								});
							});
						});
					});
			}
			if (level != 1)
			{
				FUNNYTEXT.start(0.03, false, false, null, function()
				{
					inCutscene = false;
				});
			}
			// N IF HASNT DONT CHORES GET PISSED. GOD DAMN THIS IS SUCH BAD FRAMEWORK IM SOBBING. I BETTER GET MY SHIT TOGETHER LMFAOOOOOO
		}

		// MORE BIG BRAIN SHIT(I HOPE IT WORKS)
		if (doneTasks == false && drankCoffee == true)
		{
			checkSwitches();
			if (FlxG.overlap(MOUSEBOXIGUESS, SWITCHGUI1) && FlxG.mouse.justPressed && SWITCHGUI1.on == false && inCutscene == false)
			{
				if (level > 6)
				{
					FUNNYTEXT.resetText("No switch presses for today.");
					FUNNYTEXT.start(0.03, false, false);
				}
				else
				{
					var sound:FlxSound = new FlxSound().loadEmbedded("assets/sounds/click.ogg", false, true);
					sound.volume = 0.2;
					sound.play();
					SWITCHGUI1.switchState(true);
					SWITCHGUI2.switchState(FlxG.random.bool(30));
					SWITCHGUI3.switchState(FlxG.random.bool(30));
				}
			}
			else if (FlxG.overlap(MOUSEBOXIGUESS, SWITCHGUI2) && FlxG.mouse.justPressed && SWITCHGUI2.on == false && inCutscene == false)
			{
				if (level > 6)
				{
					FUNNYTEXT.resetText("No switch presses for today.");
					FUNNYTEXT.start(0.03, false, false);
				}
				else
				{
					var sound:FlxSound = new FlxSound().loadEmbedded("assets/sounds/click.ogg", false, true);
					sound.volume = 0.2;
					sound.play();
					SWITCHGUI2.switchState(true);
					SWITCHGUI1.switchState(FlxG.random.bool(30));
					SWITCHGUI3.switchState(FlxG.random.bool(30));
				}
			}
			else if (FlxG.overlap(MOUSEBOXIGUESS, SWITCHGUI3) && FlxG.mouse.justPressed && SWITCHGUI3.on == false && inCutscene == false)
			{
				if (level > 6)
				{
					FUNNYTEXT.resetText("No switch presses for today.");
					FUNNYTEXT.start(0.03, false, false);
				}
				else
				{
					var sound:FlxSound = new FlxSound().loadEmbedded("assets/sounds/click.ogg", false, true);
					sound.volume = 0.2;
					sound.play();
					SWITCHGUI3.switchState(true);
					SWITCHGUI1.switchState(FlxG.random.bool(30));
					SWITCHGUI2.switchState(FlxG.random.bool(30));
				}
			}
		}

		/*	if (FlxG.overlap(MOUSEBOXIGUESS, SWITCH) && FlxG.mouse.pressed && level < 9)
			{
				CAFFINE.x = 138;
				CAFFINE.y = 227;
				if (level < 7)
				{
					doneTasks = true;
					var sound:FlxSound = new FlxSound().loadEmbedded("assets/sounds/click.ogg", false, true);
					SWITCHGUI1.switchState(true);
					sound.volume = 0.3;
					sound.play();
				}
				SWITCH.x = SWITCH.y = 1000; // IM LAZY LOOOL
		}*/

		if (FlxG.overlap(MOUSEBOXIGUESS, DAYS) && FlxG.mouse.pressed)
		{
			DAYS.x = DAYS.y = 1000; // IM LAZY LOOOL
			switch (level)
			{
				case 1:
					FUNNYTEXT.resetText("This shows how many days it's been! So far, only 1 day on the map. I don't know what the bar means.");
					FUNNYTEXT.start(0.03, false, false);
				default:
			}
			FUNNYTEXT.start(0.03, false, false);
			// N IF HASNT DONT CHORES GET PISSED. GOD DAMN THIS IS SUCH BAD FRAMEWORK IM SOBBING. I BETTER GET MY SHIT TOGETHER LMFAOOOOOO
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
			if (FlxG.keys.anyPressed([L]))
			{
				level++;
			}
		super.update(elapsed);
	}
}
