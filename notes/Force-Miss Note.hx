/*
    MADE BY NUBZ4LIF
    https://github.com/nubz4lif/Codename-Events

    FEEL FREE TO USE (though keep this notice please :3)

    Description: Note that visually misses even when you press it
    (NOTE: Doesn't play a miss animation, you should use a Play Animation event to ensure it syncs properly)
    (NOTE 2: Still counts towards Score + Accuracy)
*/

function onNoteCreation(event) {
    if (event.noteType == "Fake Note") {
        event.mustHit = false;
    }
}

function onPlayerHit(event) {
    if (event.noteType == "Fake Note") {
        event.showSplash = false;
        event.showRating = false;
        event.preventStrumGlow();
        event.preventAnim();
        event.preventDeletion();

        // UNCOMMENT BELOW IF YOU DON'T WANT IT TO COUNT TOWARDS SCORE + ACCURACY
        // event.cancel();
    }
}
