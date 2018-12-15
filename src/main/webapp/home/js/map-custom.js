"use strict";
$(function() {
    var mapStyle = 
    				[
				    {
				        "featureType": "water",
				        "elementType": "geometry",
				        "stylers": [
				            {
				                "color": "#e9e9e9"
				            },
				            {
				                "lightness": 17
				            }
				        ]
				    },
				    {
				        "featureType": "landscape",
				        "elementType": "geometry",
				        "stylers": [
				            {
				                "color": "#f5f5f5"
				            },
				            {
				                "lightness": 20
				            }
				        ]
				    },
				    {
				        "featureType": "road.highway",
				        "elementType": "geometry.fill",
				        "stylers": [
				            {
				                "color": "#ffffff"
				            },
				            {
				                "lightness": 17
				            }
				        ]
				    },
				    {
				        "featureType": "road.highway",
				        "elementType": "geometry.stroke",
				        "stylers": [
				            {
				                "color": "#ffffff"
				            },
				            {
				                "lightness": 29
				            },
				            {
				                "weight": 0.2
				            }
				        ]
				    },
				    {
				        "featureType": "road.arterial",
				        "elementType": "geometry",
				        "stylers": [
				            {
				                "color": "#ffffff"
				            },
				            {
				                "lightness": 18
				            }
				        ]
				    },
				    {
				        "featureType": "road.local",
				        "elementType": "geometry",
				        "stylers": [
				            {
				                "color": "#ffffff"
				            },
				            {
				                "lightness": 16
				            }
				        ]
				    },
				    {
				        "featureType": "poi",
				        "elementType": "geometry",
				        "stylers": [
				            {
				                "color": "#f5f5f5"
				            },
				            {
				                "lightness": 21
				            }
				        ]
				    },
				    {
				        "featureType": "poi.park",
				        "elementType": "geometry",
				        "stylers": [
				            {
				                "color": "#dedede"
				            },
				            {
				                "lightness": 21
				            }
				        ]
				    },
				    {
				        "elementType": "labels.text.stroke",
				        "stylers": [
				            {
				                "visibility": "on"
				            },
				            {
				                "color": "#ffffff"
				            },
				            {
				                "lightness": 16
				            }
				        ]
				    },
				    {
				        "elementType": "labels.text.fill",
				        "stylers": [
				            {
				                "saturation": 36
				            },
				            {
				                "color": "#333333"
				            },
				            {
				                "lightness": 40
				            }
				        ]
				    },
				    {
				        "elementType": "labels.icon",
				        "stylers": [
				            {
				                "visibility": "off"
				            }
				        ]
				    },
				    {
				        "featureType": "transit",
				        "elementType": "geometry",
				        "stylers": [
				            {
				                "color": "#f2f2f2"
				            },
				            {
				                "lightness": 19
				            }
				        ]
				    },
				    {
				        "featureType": "administrative",
				        "elementType": "geometry.fill",
				        "stylers": [
				            {
				                "color": "#fefefe"
				            },
				            {
				                "lightness": 20
				            }
				        ]
				    },
				    {
				        "featureType": "administrative",
				        "elementType": "geometry.stroke",
				        "stylers": [
				            {
				                "color": "#fefefe"
				            },
				            {
				                "lightness": 17
				            },
				            {
				                "weight": 1.2
				            }
				        ]
				    }
				]

    // Create the map
    var map = new google.maps.Map($('.map-canvas')[0], {
        zoom: 14,
        styles: mapStyle,
        scrollwheel: false,
        center: new google.maps.LatLng(40.72, -74)
    });

    // Add a marker
    var marker = new google.maps.Marker({
        map: map,
        position: new google.maps.LatLng(40.72, -74)
    });

    // Add a Snazzy Info Window to the marker
});



!function(t,e){if("function"==typeof define&&define.amd)define("SnazzyInfoWindow",["module","exports"],e);else if("undefined"!=typeof exports)e(module,exports);else{var o={exports:{}};e(o,o.exports),t.SnazzyInfoWindow=o.exports}}(this,function(t,e){"use strict";function o(t,e){if(!(t instanceof e))throw new TypeError("Cannot call a class as a function")}function i(t,e){if(!t)throw new ReferenceError("this hasn't been initialised - super() hasn't been called");return!e||"object"!=typeof e&&"function"!=typeof e?t:e}function s(t,e){if("function"!=typeof e&&null!==e)throw new TypeError("Super expression must either be null or a function, not "+typeof e);t.prototype=Object.create(e&&e.prototype,{constructor:{value:t,enumerable:!1,writable:!0,configurable:!0}}),e&&(Object.setPrototypeOf?Object.setPrototypeOf(t,e):t.__proto__=e)}function r(t,e){t&&e&&Object.keys(e).forEach(function(o){t[o]=e[o]})}function n(t){var e={};return r(e,f),r(e,t),Object.keys(f).forEach(function(t){var o=f[t];if("object"===(void 0===o?"undefined":d(o))){var i={};r(i,o),r(i,e[t]),e[t]=i}}),e}function h(t,e){var o=/^(-{0,1}\.{0,1}\d+(\.\d+)?)[\s|\.]*(\w*)$/;if(t&&o.test(t)){var i=o.exec(t);return{value:1*i[1],units:i[3]||"px",original:t}}return e?h(e):{original:e}}function p(t,e){if(t){for(;t.firstChild;)t.removeChild(t.firstChild);e&&("string"==typeof e?t.innerHTML=e:t.appendChild(e))}}function a(t){return"top"===t?"bottom":"bottom"===t?"top":"left"===t?"right":"right"===t?"left":t}function l(t){return t.charAt(0).toUpperCase()+t.slice(1)}function c(t){if(void 0!==t&&null!==t&&google){if(t instanceof google.maps.LatLng)return t;if(void 0!==t.lat&&void 0!==t.lng)return new google.maps.LatLng(t)}return null}Object.defineProperty(e,"__esModule",{value:!0});var _=function(){function t(t,e){for(var o=0;o<e.length;o++){var i=e[o];i.enumerable=i.enumerable||!1,i.configurable=!0,"value"in i&&(i.writable=!0),Object.defineProperty(t,i.key,i)}}return function(e,o,i){return o&&t(e.prototype,o),i&&t(e,i),e}}(),d="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(t){return typeof t}:function(t){return t&&"function"==typeof Symbol&&t.constructor===Symbol&&t!==Symbol.prototype?"symbol":typeof t},u={h:"0px",v:"3px",blur:"6px",spread:"0px",color:"#000"},f={placement:"top",pointer:!0,openOnMarkerClick:!0,closeOnMapClick:!0,closeWhenOthersOpen:!1,showCloseButton:!0,panOnOpen:!0,edgeOffset:{top:20,right:20,bottom:20,left:20}},m=function(t){function e(t){o(this,e);var s=i(this,(e.__proto__||Object.getPrototypeOf(e)).call(this,t));s._html=null,s._opts=n(t),s._callbacks=s._opts.callbacks||{},s._marker=s._opts.marker,s._map=s._opts.map,s._position=c(s._opts.position),s._isOpen=!1,s._listeners=[],google&&s._marker&&s._opts.openOnMarkerClick&&s.trackListener(google.maps.event.addListener(s._marker,"click",function(){s.getMap()||s.open()}),!0),s._position&&!s._opts.offset&&(s._opts.offset={top:"0px",left:"0px"});var r=t.placement||s._opts.position;return("string"==typeof r||r instanceof String)&&(r=r.toLowerCase()),s._opts.placement="top"!==r&&"bottom"!==r&&"left"!==r&&"right"!==r?f.placement:r,r=s._opts.position,void 0===r||null===r||"string"==typeof r||r instanceof String||(s._opts.position=r),void 0!==s._opts.border&&s._opts.border!==!0||(s._opts.border={}),void 0===s._opts.pointer&&(s._opts.pointer=f.pointer),void 0!==s._opts.shadow&&s._opts.shadow!==!0||(s._opts.shadow={}),s}return s(e,t),_(e,[{key:"activateCallback",value:function(t){var e=this._callbacks[t];return e?e.apply(this):void 0}},{key:"trackListener",value:function(t,e){this._listeners.push({listener:t,persistent:e})}},{key:"clearListeners",value:function(t){google&&this._listeners&&(this._listeners.forEach(function(e){!t&&e.persistent||(google.maps.event.removeListener(e.listener),e.listener=null)}),this._listeners=this._listeners.filter(function(t){return null!=t.listener}))}},{key:"isOpen",value:function(){return this._isOpen}},{key:"open",value:function(){var t=this.activateCallback("beforeOpen");(void 0===t||t)&&(this._marker?this.setMap(this._marker.getMap()):this._map&&this._position&&this.setMap(this._map))}},{key:"close",value:function(){var t=this.activateCallback("beforeClose");(void 0===t||t)&&(this.clearListeners(),this.setMap(null))}},{key:"destroy",value:function(){this.getMap()&&this.setMap(null),this.clearListeners(!0)}},{key:"setContent",value:function(t){this._opts.content=t,this._html&&this._html.content&&p(this._html.content,t)}},{key:"setPosition",value:function(t){this._position=c(t),this._isOpen&&this._position&&(this.draw(),this.resize(),this.reposition())}},{key:"getWrapper",value:function(){return this._html?this._html.wrapper:null}},{key:"draw",value:function(){if(this.getMap()&&this._html&&(this._marker||this._position)){var t=this._opts.offset;t&&(t.left&&(this._html.wrapper.style.marginLeft=t.left),t.top&&(this._html.wrapper.style.marginTop=t.top));var e=this._opts.backgroundColor;if(e&&(this._html.contentWrapper.style.backgroundColor=e,this._opts.pointer&&(this._html.pointerBg.style["border"+l(this._opts.placement)+"Color"]=e)),this._opts.padding&&(this._html.contentWrapper.style.padding=this._opts.padding,this._opts.shadow&&(this._html.shadowFrame.style.padding=this._opts.padding)),this._opts.borderRadius&&(this._html.contentWrapper.style.borderRadius=this._opts.borderRadius,this._opts.shadow&&(this._html.shadowFrame.style.borderRadius=this._opts.borderRadius)),this._opts.fontSize&&(this._html.wrapper.style.fontSize=this._opts.fontSize),this._opts.fontColor&&(this._html.contentWrapper.style.color=this._opts.fontColor),this._opts.pointer&&this._opts.pointer!==!0&&(this._opts.shadow&&(this._html.shadowPointer.style.width=this._opts.pointer,this._html.shadowPointer.style.height=this._opts.pointer),this._html.pointerBorder&&(this._html.pointerBorder.style.borderWidth=this._opts.pointer),this._html.pointerBg.style.borderWidth=this._opts.pointer),this._opts.border){var o=0;if(void 0!==this._opts.border.width&&(o=h(this._opts.border.width,"0px"),this._html.contentWrapper.style.borderWidth=o.value+o.units),o=Math.round((this._html.contentWrapper.offsetWidth-this._html.contentWrapper.clientWidth)/2),o=h(o+"px","0px"),this._opts.pointer){var i=Math.min(this._html.pointerBorder.offsetHeight,this._html.pointerBorder.offsetWidth);i=h(i+"px","0px");var s=Math.round(o.value*(1.41421356237-1));s=Math.min(s,i.value),this._html.pointerBg.style.borderWidth=i.value-s+i.units;var r=l(a(this._opts.placement));this._html.pointerBg.style["margin"+r]=s+o.units,this._html.pointerBg.style[this._opts.placement]=-o.value+o.units}var n=this._opts.border.color;n&&(this._html.contentWrapper.style.borderColor=n,this._html.pointerBorder&&(this._html.pointerBorder.style["border"+l(this._opts.placement)+"Color"]=n))}if(this._opts.shadow){var p=this._opts.shadow,c=function(t){var e=p[t];return void 0!==e&&null!=e};if(c("h")||c("v")||c("blur")||c("spread")||c("color")){var _=h(p.h,u.h),d=h(p.v,u.v),f=h(p.blur,u.blur),m=h(p.spread,u.spread),g=p.color||u.color,v=function(t,e){return t+" "+e+" "+f.original+" "+m.original+" "+g};this._html.shadowFrame.style.boxShadow=v(_.original,d.original);var b=.7071067811865474*(_.value-d.value)+_.units,y=.7071067811865474*(_.value+d.value)+d.units;this._html.shadowPointerInner.style.boxShadow=v(b,y)}this._opts.shadow.opacity&&(this._html.shadowWrapper.style.opacity=this._opts.shadow.opacity)}var w=this.getProjection().fromLatLngToDivPixel(this._position||this._marker.position);w&&(this._html.floatWrapper.style.top=Math.floor(w.y)+"px",this._html.floatWrapper.style.left=Math.floor(w.x)+"px"),this._isOpen||(this._isOpen=!0,this.resize(),this.reposition(),this.activateCallback("afterOpen"),google&&google.maps.event.trigger(this.getMap(),"snazzy-info-window-opened",this))}}},{key:"onAdd",value:function(){var t=this;if(!this._html){var e=function(t,e){if(t&&e)for(var o=0;o<e.length;o++){var i=e[o];i&&(t.className&&(t.className+=" "),t.className+="si-"+i)}},o=function(){for(var t=arguments.length,o=Array(t),i=0;i<t;i++)o[i]=arguments[i];var s=document.createElement("div");return e(s,o),s};if(this._html={},this._html.wrapper=o("wrapper-"+this._opts.placement),this._opts.wrapperClass&&(this._html.wrapper.className+=" "+this._opts.wrapperClass),this._opts.border&&e(this._html.wrapper,["has-border"]),this._opts.shadow&&(this._html.shadowWrapper=o("shadow-wrapper-"+this._opts.placement),this._html.shadowFrame=o("frame","shadow-frame"),this._html.shadowWrapper.appendChild(this._html.shadowFrame),this._opts.pointer&&(this._html.shadowPointer=o("shadow-pointer-"+this._opts.placement),this._html.shadowPointerInner=o("shadow-inner-pointer-"+this._opts.placement),this._html.shadowPointer.appendChild(this._html.shadowPointerInner),this._html.shadowWrapper.appendChild(this._html.shadowPointer)),this._html.wrapper.appendChild(this._html.shadowWrapper)),this._html.contentWrapper=o("frame","content-wrapper"),this._html.content=o("content"),this._opts.content&&p(this._html.content,this._opts.content),this._opts.showCloseButton){if(this._opts.closeButtonMarkup){var i=document.createElement("div");p(i,this._opts.closeButtonMarkup),this._html.closeButton=i.firstChild}else this._html.closeButton=document.createElement("button"),this._html.closeButton.setAttribute("type","button"),this._html.closeButton.innerHTML="&#215;",e(this._html.closeButton,["close-button"]);this._html.contentWrapper.appendChild(this._html.closeButton)}this._html.contentWrapper.appendChild(this._html.content),this._html.wrapper.appendChild(this._html.contentWrapper),this._opts.pointer&&(this._opts.border&&(this._html.pointerBorder=o("pointer-"+this._opts.placement,"pointer-border-"+this._opts.placement),this._html.wrapper.appendChild(this._html.pointerBorder)),this._html.pointerBg=o("pointer-"+this._opts.placement,"pointer-bg-"+this._opts.placement),this._html.wrapper.appendChild(this._html.pointerBg)),this._html.floatWrapper=o("float-wrapper"),this._html.floatWrapper.appendChild(this._html.wrapper),this.getPanes().floatPane.appendChild(this._html.floatWrapper);var s=this.getMap();if(this.clearListeners(),this._opts.closeOnMapClick&&this.trackListener(google.maps.event.addListener(s,"click",function(){t.close()})),this._opts.closeWhenOthersOpen&&this.trackListener(google.maps.event.addListener(s,"snazzy-info-window-opened",function(e){t!==e&&t.close()})),google){this._previousWidth=null,this._previousHeight=null,this.trackListener(google.maps.event.addListener(s,"bounds_changed",function(){var e=s.getDiv(),o=e.offsetWidth,i=e.offsetHeight,r=t._previousWidth,n=t._previousHeight;null!==r&&null!==n&&r===o&&n===i||(t._previousWidth=o,t._previousHeight=i,t.resize())})),this._marker&&this.trackListener(google.maps.event.addListener(this._marker,"position_changed",function(){t.draw()})),this._opts.showCloseButton&&!this._opts.closeButtonMarkup&&this.trackListener(google.maps.event.addDomListener(this._html.closeButton,"click",function(e){e.cancelBubble=!0,e.stopPropagation&&e.stopPropagation(),t.close()}));["click","dblclick","rightclick","contextmenu","drag","dragend","dragstart","mousedown","mouseout","mouseover","mouseup","touchstart","touchend","touchmove","wheel","mousewheel","DOMMouseScroll","MozMousePixelScroll"].forEach(function(e){t.trackListener(google.maps.event.addDomListener(t._html.wrapper,e,function(t){t.cancelBubble=!0,t.stopPropagation&&t.stopPropagation()}))})}this.activateCallback("open")}}},{key:"onRemove",value:function(){if(this.activateCallback("close"),this._html){var t=this._html.floatWrapper.parentElement;t&&t.removeChild(this._html.floatWrapper),this._html=null}this._isOpen=!1,this.activateCallback("afterClose")}},{key:"getMapInnerBounds",value:function(){var t=this.getMap().getDiv().getBoundingClientRect(),e={top:t.top+this._opts.edgeOffset.top,right:t.right-this._opts.edgeOffset.right,bottom:t.bottom-this._opts.edgeOffset.bottom,left:t.left+this._opts.edgeOffset.left};return e.width=e.right-e.left,e.height=e.bottom-e.top,e}},{key:"reposition",value:function(){if(this._opts.panOnOpen&&this._html){var t=this.getMapInnerBounds(),e=this._html.wrapper.getBoundingClientRect(),o=0,i=0;t.left>=e.left?o=e.left-t.left:t.right<=e.right&&(o=e.left-(t.right-e.width)),t.top>=e.top?i=e.top-t.top:t.bottom<=e.bottom&&(i=e.top-(t.bottom-e.height)),0===o&&0===i||this.getMap().panBy(o,i)}}},{key:"resize",value:function(){if(this._html){var t=this.getMapInnerBounds(),e=t.width;void 0!==this._opts.maxWidth&&(e=Math.min(e,this._opts.maxWidth)),e-=this._html.wrapper.offsetWidth-this._html.content.offsetWidth,this._html.content.style.maxWidth=e+"px";var o=t.height;void 0!==this._opts.maxHeight&&(o=Math.min(o,this._opts.maxHeight)),o-=this._html.wrapper.offsetHeight-this._html.content.offsetHeight,this._html.content.style.maxHeight=o+"px"}}}]),e}(google.maps.OverlayView);e.default=m,t.exports=e.default});
//# sourceMappingURL=snazzy-info-window.min.js.map