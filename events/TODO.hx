/*
    MADE BY NUBZ4LIF
    https://github.com/nubz4lif/Codename-Events

    FEEL FREE TO USE (though keep this notice please :3)

    Description: Shows text on screen mid-song as a dev-only reminder (only shows up in dev mode)
    (NOTE: Make sure you remove this, or change the below final to false in your final project)
*/

final enableTODO:Bool = true;

if(!Options.devMode || !enableTODO) {
    disableScript();
    return;
}

var todoText:FlxText;
function postCreate() {
    todoText = new FunkinText(0, 0);
    todoText.autoSize = true;
    todoText.fieldWidth = 1280;
    todoText.alignment = "center";
    todoText.camera = newHUDcam;

    todoText.text = "";
    todoText.screenCenter();
    todoText.y = 600;
    add(todoText);
}

function onEvent(e) {
    var event = e.event;
    if (event.name == "TODO") {
        trace("TODO (beat "+Std.string(Math.round(Conductor.getTimeInBeats(event.time)))+"): "+ Std.string(event.params[0]));
        todoText.text = "TODO: " + Std.string(event.params[0]);
    }
}
