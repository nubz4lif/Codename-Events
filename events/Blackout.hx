/*
    MADE BY NUBZ4LIF
    https://github.com/nubz4lif/Codename-Events

    FEEL FREE TO USE (though keep this notice please :3)

    Description: Turns the screen fully black by disabling both cameras (also includes an option to keep the HUD visible)
*/

var blackedOut:Bool = false;
function blackOut(keepHud = true) {
    camGame.visible = false;
    camHUD.visible = (keepHud == true);

    blackedOut = true;
}

function unBlackout() {
    camGame.visible = true;
    camHUD.visible = true;

    blackedOut = false;
}

function onEvent(e) {
    if (e.event.name == "Blackout") {
        var params:Array = e.event.params;
        params[0] == true ? blackOut(!(params[1] == true)) : unBlackout();
    }
}

function onGameOver(ev) {
    if(blackedOut) unBlackout();
}

// Auto-enables the blackout if the event is at the very start of the song
function postCreate() {
    for (e in PlayState.SONG.events) {
        if (e.name == "Blackout" && e.time < 10) {
            executeEvent(e);
            break;
        }
    }
}
