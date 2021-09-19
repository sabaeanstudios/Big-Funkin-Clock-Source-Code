package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitLeftAngy:FlxSprite;
	var portraitLeftSad:FlxSprite;
	var portraitLeftMeh:FlxSprite;
	var portraitLeftHapy:FlxSprite;
	var portraitLeftMic:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
				case 'thorns':
			case 'clocked':
				FlxG.sound.playMusic(Paths.music('errortrack'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
		
			case 'clocked':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
							
			case 'crunch':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;

			case 'overtime':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;

		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

		if (PlayState.SONG.song.toLowerCase()=='clocked' || PlayState.SONG.song.toLowerCase()=='crunch' || PlayState.SONG.song.toLowerCase()=='overtime')
		{
		portraitLeft = new FlxSprite(250, 170);
		portraitLeft.frames = Paths.getSparrowAtlas('clockAngry/clockportrait');
		portraitLeft.animation.addByPrefix('enter', 'Clock Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * 1.6));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitLeftAngy = new FlxSprite(410, 170);
		portraitLeftAngy.frames = Paths.getSparrowAtlas('clockAngry/clockAngryTalk');
		portraitLeftAngy.animation.addByPrefix('enter', 'Angy Portrait Enter', 24, false);
		portraitLeftAngy.setGraphicSize(Std.int(portraitLeftAngy.width * 1.6));
		portraitLeftAngy.updateHitbox();
		portraitLeftAngy.scrollFactor.set();
		add(portraitLeftAngy);
		portraitLeftAngy.visible = false;

		portraitLeftSad = new FlxSprite(410, 170);
		portraitLeftSad.frames = Paths.getSparrowAtlas('clockAngry/clockSad');
		portraitLeftSad.animation.addByPrefix('enter', 'Sad Portrait Enter', 24, false);
		portraitLeftSad.setGraphicSize(Std.int(portraitLeftSad.width * 1.6));
		portraitLeftSad.updateHitbox();
		portraitLeftSad.scrollFactor.set();
		add(portraitLeftSad);
		portraitLeftSad.visible = false;

		portraitLeftMeh = new FlxSprite(410, 170);
		portraitLeftMeh.frames = Paths.getSparrowAtlas('clockAngry/ClockMeh');
		portraitLeftMeh.animation.addByPrefix('enter', 'Meh Portrait Enter', 24, false);
		portraitLeftMeh.setGraphicSize(Std.int(portraitLeftMeh.width * 1.6));
		portraitLeftMeh.updateHitbox();
		portraitLeftMeh.scrollFactor.set();
		add(portraitLeftMeh);
		portraitLeftMeh.visible = false;

		portraitLeftMic = new FlxSprite(410, 170);
		portraitLeftMic.frames = Paths.getSparrowAtlas('clockAngry/clockMic');
		portraitLeftMic.animation.addByPrefix('enter', 'Mic Portrait Enter', 24, false);
		portraitLeftMic.setGraphicSize(Std.int(portraitLeftMic.width * 1.6));
		portraitLeftMic.updateHitbox();
		portraitLeftMic.scrollFactor.set();
		add(portraitLeftMic);
		portraitLeftMic.visible = false;

		portraitLeftHapy = new FlxSprite(410, 170);
		portraitLeftHapy.frames = Paths.getSparrowAtlas('clockAngry/clockHapy');
		portraitLeftHapy.animation.addByPrefix('enter', 'Hapy Portrait Enter', 24, false);
		portraitLeftHapy.setGraphicSize(Std.int(portraitLeftHapy.width * 1.6));
		portraitLeftHapy.updateHitbox();
		portraitLeftHapy.scrollFactor.set();
		add(portraitLeftHapy);
		portraitLeftHapy.visible = false;

		portraitRight = new FlxSprite(410, 170);
		portraitRight.frames = Paths.getSparrowAtlas('clockAngry/bfportrait');
		portraitRight.animation.addByPrefix('enter', 'BF portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * 1.6));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
		}
		

		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'ComicNeueSansID';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'ComicNeueSansID';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);
		
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'clocked')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{		
			case 'dad':
				portraitLeftAngy.visible = false;
				portraitRight.visible = false;
				if (!portraitLeft.visible)

				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('clockText'), 0.6)];
				}
			case 'angy':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitLeftAngy.visible)
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('clockText'), 0.6)];
				{
				portraitLeftAngy.visible = true;
				portraitLeftAngy.animation.play('enter');
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('clockText'), 0.6)];
				}
			case 'sad':
				portraitRight.visible = false;
				portraitLeftMeh.visible = false;
				portraitLeftMic.visible = false;
				portraitLeftHapy.visible = false;
				if (!portraitLeftSad.visible)
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('clockText'), 0.6)];
				{
				portraitLeftSad.visible = true;
				portraitLeftSad.animation.play('enter');
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('clockText'), 0.6)];
				}

			case 'meh':
				portraitRight.visible = false;
				portraitLeftSad.visible = false;
				portraitLeftMic.visible = false;
				portraitLeftHapy.visible = false;
				if (!portraitLeftMeh.visible)
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('clockText'), 0.6)];
				{
				portraitLeftMeh.visible = true;
				portraitLeftMeh.animation.play('enter');
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('clockText'), 0.6)];
				}

			case 'mic':
				portraitRight.visible = false;
				portraitLeftSad.visible = false;
				portraitLeftMeh.visible = false;
				portraitLeftHapy.visible = false;
				if (!portraitLeftMic.visible)
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('clockText'), 0.6)];
				{
				portraitLeftMic.visible = true;
				portraitLeftMic.animation.play('enter');
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('clockText'), 0.6)];
				}

			case 'hapy':
				portraitRight.visible = false;
				portraitLeftSad.visible = false;
				portraitLeftMeh.visible = false;
				portraitLeftMic.visible = false;
				if (!portraitLeftHapy.visible)
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('clockText'), 0.6)];
				{
				portraitLeftHapy.visible = true;
				portraitLeftHapy.animation.play('enter');
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('clockText'), 0.6)];
				}

			case 'bf':
				portraitLeftMeh.visible = false;			
				portraitLeftAngy.visible = false;
				portraitLeftSad.visible = false;
				portraitLeft.visible = false;
				portraitLeftHapy.visible = false;
				portraitLeftMic.visible = false;
				if (!portraitRight.visible)
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
