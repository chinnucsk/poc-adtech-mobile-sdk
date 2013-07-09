(function(){console={};console.log=function(a){var b=document.createElement("iframe");b.setAttribute("src","ios-log:#iOS#"+a);document.documentElement.appendChild(b);b.parentNode.removeChild(b);b=null};console.debug=console.log;console.info=console.log;console.warn=console.log;console.error=console.log})();(function(){var a=window.mrdbridge={};var b={};var c=[];var d=false;a.fireChangeEvent=function(a){var c=b["change"];if(c!=null){for(var d=0;d<c.length;d++){c[d](a)}}};a.fireErrorEvent=function(a,c){var d=b["error"];if(d!=null){for(var e=0;e<d.length;e++){d[e](a,c)}}};a.fireReadyEvent=function(){var a=b["ready"];if(a!=null){for(var c=0;c<a.length;c++){a[c]()}}};a.nativeCallComplete=function(a){if(c.length==0){d=false;return}var b=c.pop();window.location=b};a.executeNativeCall=function(a){var b="mraid://"+a;var e;var f=true;for(var g=1;g<arguments.length;g+=2){e=arguments[g+1];if(e==null){continue}if(f){b+="?";f=false}else{b+="&"}b+=arguments[g]+"="+escape(e)}if(d){c.push(b)}else{d=true;window.location=b}};a.addEventListener=function(a,c){var d=b[a];if(d==null){b[a]=[];d=b[a]}for(var e in d){if(c==e){return}}d.push(c)};a.removeEventListener=function(a,c){var d=b[a];if(d!=null){var e=handler.indexOf(c);if(e!=-1){d.splice(e,1)}}}})();(function(){var a=window.mraid={};var b=window.mrdbridge;var c=a.STATES={LOADING:"loading",DEFAULT:"default",EXPANDED:"expanded",HIDDEN:"hidden"};var d=a.EVENTS={READY:"ready",ERROR:"error",INFO:"info",STATECHANGE:"stateChange",VIEWABLECHANGE:"viewableChange"};var e=a.PLACEMENTS={UNKNOWN:"unknown",INLINE:"inline",INTERSTITIAL:"interstitial"};var f=a.VERSION="1.0";var g={width:0,height:0,useCustomClose:false,isModal:true,lockOrientation:false,useBackground:false,backgroundColor:0,backrgoundOpacity:.6};var h=false;var i=false;var j=false;var k=c.LOADING;var l=e.UNKNOWN;var m={width:0,height:0};var n={};var o=function(a){this.event=a;this.count=0;var b={};this.add=function(a){var c=String(a);if(!b[c]){b[c]=a;this.count++}};this.remove=function(a){var c=String(a);if(b[c]){b[c]=null;delete b[c];this.count--;return true}else{return false}};this.removeAll=function(){for(var a in b){if(b.hasOwnProperty(a))this.remove(b[a])}};this.broadcast=function(a){for(var c in b){if(b.hasOwnProperty(c))b[c].apply({},a)}};this.toString=function(){var c=[a,":"];for(var d in b){if(b.hasOwnProperty(d))c.push("|",d,"|")}return c.join("")}};var p=function(a){if(a==null)return null;var b=function(){};b.prototype=a;return new b};var q=function(a){if(typeof a=="object"){if(a.push){var b=[];for(var c=0;c<a.length;c++){b.push(a[c])}return"["+b.join(",")+"]"}else{var b=[];for(var c in a){b.push("'"+c+"':"+a[c])}return"{"+b.join(",")+"}"}}else{return String(a)}};var r=function(a,b,c,e){if(e){if(a===undefined){t(d.ERROR,"Required object missing.",c);return false}else{for(var f in b){if(b.hasOwnProperty(f)&&a[f]===undefined){t(d.ERROR,"Object missing required property "+f,c);return false}}}}for(var f in a){if(!b[f]){t(d.ERROR,"Invalid property specified - "+f+".",c);return false}else if(!b[f](a[f])){t(d.ERROR,"Value of property "+f+" is not valid type.",c);return false}}return true};var s=function(a,b){for(var c in b)if(b[c]==a)return true;return false};var t=function(){var a=new Array(arguments.length);for(var b=0;b<arguments.length;b++)a[b]=arguments[b];var c=a.shift();if(n[c])n[c].broadcast(a)};var u={state:function(a){if(k==c.LOADING){t(d.INFO,"SDK initialized")}t(d.INFO,"setting state to "+q(a));k=a;t(d.STATECHANGE,k)},expandProperties:function(a){t(d.INFO,"merging expandProperties with "+q(a));for(var b in a){if(a.hasOwnProperty(b))g[b]=a[b]}},screenSize:function(a){t(d.INFO,"setting screenSize to "+q(a));for(var b in a){if(a.hasOwnProperty(b))m[b]=a[b]}if(!j){g["width"]=m["width"];g["height"]=m["height"]}},viewable:function(a){h=a;t(d.INFO,"setting viewable to "+q(a));t(d.VIEWABLECHANGE,h)},placementType:function(a){t(d.INFO,"setting placement to "+q(a));l=a}};var v={isModal:function(a){return a===true||a===false},useCustomClose:function(a){return a===true||a===false},width:function(a){return!isNaN(a)&&a>=0},height:function(a){return!isNaN(a)&&a>=0}};b.addEventListener("change",function(a){for(var b in a){var c=u[b];c(a[b])}});b.addEventListener("error",function(a,b){t(d.ERROR,a,b)});b.addEventListener("ready",function(){t(d.READY)});a.addEventListener=function(a,b){if(!a||!b){t(d.ERROR,"Both event and listener are required.","addEventListener")}else if(!s(a,d)){t(d.ERROR,"Unknown event: "+a,"addEventListener")}else{if(!n[a])n[a]=new o(a);n[a].add(b)}};a.close=function(){b.executeNativeCall("close")};a.expand=function(a){if(k!==c.DEFAULT){t(d.ERROR,"cannot expand when state is "+q(k),"expand")}else{t(d.INFO,"expanding");var e=["w",g.width,"h",g.height];if(a){e=e.concat(["url",a])}e=e.concat(["shouldUseCustomClose",g.useCustomClose?"true":"false"]);e=e.concat(["lockOrientation",g.lockOrientation]);b.executeNativeCall("expand",e)}};a.getExpandProperties=function(){return p(g)};a.getPlacementType=function(){return l};a.getState=function(){return k};a.getVersion=function(){return a.VERSION};a.isViewable=function(){return h};a.open=function(a){if(!a){t(d.ERROR,"URL is required.","open")}else{b.executeNativeCall("open","url",a)}};a.removeEventListener=function(a,b){if(!a){t(d.ERROR,"Must specify an event.","removeEventListener")}else{if(b&&(!n[a]||!n[a].remove(b))){t(d.ERROR,"Listener not currently registered for event","removeEventListener");return}else{n[a].removeAll()}if(n[a].count==0){n[a]=null;delete n[a]}}};a.setExpandProperties=function(a){if(r(a,v,"setExpandProperties",false)){if(a.hasOwnProperty("useCustomClose"))i=true;if(a.hasOwnProperty("width")||a.hasOwnProperty("height"))j=true;var b=["width","height","useCustomClose","isModal"];for(var c=0;c<b.length;c++){var d=b[c];if(a.hasOwnProperty(d))g[d]=a[d]}}};a.useCustomClose=function(a){g.useCustomClose=a;i=true;b.executeNativeCall("usecustomclose","shouldUseCustomClose",a)}})()