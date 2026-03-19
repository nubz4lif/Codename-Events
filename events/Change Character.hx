/*
    MADE BY NUBZ4LIF
    https://github.com/nubz4lif/Codename-Events

    FEEL FREE TO USE (though keep this notice please :3)

    Description: Changes the strumlines character (first slot only). Meant to emulate the Change Character event in Psych Engine
*/

var preloadedChars:Map<String, Character> = [];
var preloadedIcons:Map<String, FlxSprite> = [];

function postCreate() {
    for (event in PlayState.SONG.events) {
        if (event.name == "Change Character" && !preloadedChars.exists(event.params[1])) {
            var oldChar = strumLines.members[event.params[0]].characters[0];

            var newChar = new Character(oldChar.x, oldChar.y, event.params[1], oldChar.isPlayer);
            newChar.visible = false;
            newChar.active = false;
            preloadedChars.set(event.params[1], newChar);
        }
    }
}

function onEvent(ev) {
    var event = ev.event;
    if(event.name == "Change Character") {
        var strumLine = strumLines.members[event.params[0]];

        var oldChar = strumLine.characters[0];
        var newChar = preloadedChars.get(event.params[1]);

        if (newChar == oldChar) return;

        // Syncing
        newChar.stunned = oldChar.stunned;
        newChar.__stunnedTime = oldChar.__stunnedTime;

        newChar.playAnim(oldChar.animation.name);
        newChar.lastAnimContext = oldChar.lastAnimContext;
        newChar.animation?.curAnim?.curFrame = oldChar.animation?.curAnim?.curFrame;

        // Positioning
        var strumLineData = SONG.strumLines[strumLine.ID];

        var charPosName:String = strumLineData.position == null ? (switch(strumLineData.type) {
            case 0: "dad";
            case 1: "boyfriend";
            case 2: "girlfriend";
        }) : strumLineData.position;
        PlayState.instance.stage.applyCharStuff(newChar, charPosName, strumLine.ID);

        // Replacement
        oldChar.visible = false;
        oldChar.active = false;

        newChar.visible = true;
        newChar.active = true;

        insert(members.indexOf(oldChar),newChar);
        remove(oldChar);
        strumLine.characters[0] = newChar;
    }
}
