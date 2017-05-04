using Toybox.Application as App;

class Bike6DataApp extends App.AppBase {

    function getInitialView() {
        return [ new Bike6DataField() ];
    }

}