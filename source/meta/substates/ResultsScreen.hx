package meta.substates;

import backend.Controls.Control;
import openfl.geom.Matrix;
import openfl.display.BitmapData;
import flixel.system.FlxSound;
import flixel.util.FlxAxes;
import flixel.FlxSubState;
import flixel.input.FlxInput;
import flixel.input.keyboard.FlxKey;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import lime.utils.Assets;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.input.FlxKeyManager;

using StringTools;

class ResultsScreen extends MusicBeatSubstate
{
    var background:FlxSprite;
    var theText:FlxText;

    override function create()
        {	
            background = new FlxSprite(0,0).makeGraphic(FlxG.width,FlxG.height,FlxColor.BLACK);
            background.scrollFactor.set();
            background.alpha = 0;
            add(background);

            theText = new FlxText(20,-75,0,'Judgements:\nSicks - ${PlayState.instance.sicks}\nGoods - ${PlayState.instance.goods}\nBads - ${PlayState.instance.bads}\nShits - ${PlayState.instance.shits}\nMisses: ${PlayState.instance.songMisses}\n\nScore: ${Std.int(PlayState.instance.songScore)}\nAccuracy: ${Highscore.floorDecimal(PlayState.instance.ratingPercent * 100, 2)}%\n\nRank: ${PlayState.instance.currentRank.toUpperCase()}\n');
            theText.setFormat(Paths.font('vcr.ttf'), 32, FlxColor.WHITE);
            theText.setBorderStyle(FlxTextBorderStyle.OUTLINE,FlxColor.BLACK,4,1);
            theText.scrollFactor.set();
            add(theText);

            var versionShit:FlxText = new FlxText(12, FlxG.height - 34, 0, "Press Enter to Continue", 12);
            versionShit.scrollFactor.set();
            versionShit.setFormat(Paths.font('vcr.ttf'), 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            add(versionShit);

            FlxTween.tween(background, {alpha: 0.5},0.5);
            FlxTween.tween(theText, {y:200},0.5,{ease: FlxEase.expoInOut});

            FlxG.sound.playMusic(Paths.music('rank-screen'));

            super.create();

            cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
        }

    override function update(elapsed:Float)
	    {
            var accepted = controls.ACCEPT;

            if (accepted) {
                PlayState.usedPractice = false;
				PlayState.usedBotplay = false;
				PlayState.changedDifficulty = false;

                FlxG.sound.playMusic(Paths.music('freakyMenu'));

                if (PlayState.isStoryMode)
                {
                    PlayState.instance.nextSong();
                //  FlxG.sound.playMusic(Paths.music('freakyMenu'));
                //  FlxG.switchState(new StoryMenuState());
                }
                else
                    FlxG.switchState(new FreeplayState());
            }

            super.update(elapsed);
        }
}