module.exports = {
    callEnded: function () {
        cordova.exec(null, null, "CallHooks", "callEnded", []);
    }
};