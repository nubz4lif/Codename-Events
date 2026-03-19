/*
    MADE BY NUBZ4LIF
    https://github.com/nubz4lif/Codename-Events

    FEEL FREE TO USE (though keep this notice please :3)

    Description: Changes the stage mid-song (may cause issues with some stages!)
*/

import funkin.game.Stage;

import Xml;

var stageList:Map<String, Stage> = [];
var curStage:Stage;

function createStage(sceneName) {
    if(stageList.exists(sceneName)) return stageList.get(sceneName);

    var newStage = new Stage(sceneName);
    newStage.state = PlayState.instance;
    hideStage(newStage);

    stageList[sceneName] = newStage;
    add(newStage);
    return newStage;
}

function hideStage(stage) {
    for (sprite in stage.stageSprites) {
        sprite.visible = false;
    }

    for (xmlScript in stage.xmlImportedScripts) {
        xmlScript.getScript().active = false;
    }
}

function showStage(stage) {
    for (sprite in stage.stageSprites) {
        sprite.visible = true;
    }

    for (xmlScript in stage.xmlImportedScripts) {
        xmlScript.getScript().active = true;
    }
}

function create() {
    stageList.set(PlayState.SONG.stage, PlayState.instance.stage);
    curStage = PlayState.instance.stage;

    for (event in PlayState.SONG.events) {
        if (event.name == "Change Stage" && event.params[0] != "" && event.params[2]) {
            if (!stageList.exists(event.params[0])) {
                createStage(event.params[0],false);
            }
        }
    }
    showStage(PlayState.instance.stage);
}

function postCreate() {
    PlayState.instance.defaultCamZoom = PlayState.instance.stage.defaultZoom;
    PlayState.instance.camZooming = true;
}

function onEvent(e) {
    var event = e.event;
    if (event.name == "Change Stage") {
        var stageName = event.params[0] != "" ? event.params[0] : PlayState.SONG.stage;
        var deleteOld = event.params[1];

        var stage = stageList.exists(stageName) ? stageList.get(stageName) : createStage(stageName);
        if (stage == curStage) return;

        if(!deleteOld) {
            hideStage(curStage);
        } else {
            hideStage(curStage);
            stageList.remove(curStage.stageName);
            curStage.destroy();
        }

        for (strumLine in strumLines.members) {
            var strumLineData = SONG.strumLines[strumLine.ID];

            var charPosName:String = strumLineData.position == null ? (switch(strumLineData.type) {
				case 0: "dad";
				case 1: "boyfriend";
				case 2: "girlfriend";
			}) : strumLineData.position;
            for (char in strumLine.characters) {
                remove(char);
                stage.applyCharStuff(char, charPosName, strumLine.ID);
            }
        }

        showStage(stage);
        curStage = stage;
        PlayState.instance.stage = curStage;

        // Camera movement
        PlayState.instance.defaultCamZoom = stage.defaultZoom;
        PlayState.instance.moveCamera();
        FlxG.camera.snapToTarget();
    }
}

