/**
 * FlexSpy 1.4-beta
 *
 * <p>Code released under WTFPL [http://sam.zoy.org/wtfpl/]</p>
 * @author Arnaud Pichery [http://coderpeon.ovh.org]
 * @author Frédéric Thomas
 */
package com.flexspy.impl {

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Rectangle;
import flash.utils.getQualifiedClassName;

import mx.core.EdgeMetrics;

/**
 * Represents a row in the Properties or Styles DataGrid
 */
public class PropertyEditorItem extends EventDispatcher {

    private var _name:String;
    private var _uri:String; // URI of the namespace of the attribute
    private var _value:*;
    private var _editable:Boolean;
    private var _format:String;
    private var _type:String;
    private var _enumeration:String;

    public function PropertyEditorItem(itemName:String) {
        _name = itemName;
    }

    public function get name():String {
        return _name;
    }

    public function get displayName():String {
        if (uri == null || uri == "") {
            return name;
        } else {
            return "{" + uri + "}" + name;
        }
    }

    public function get uri():String {
        return _uri;
    }

    public function set uri(v:String):void {
        _uri = v;
    }

    public function get displayValue():String {
        if (type == "Array") {
            return getArrayDisplayValue(value as Array);
        } else {
            return getItemDisplayValue(value);
        }
    }

    public function get value():* {
        return _value;
    }

    [Bindable("valueChange")]
    public function set value(v:*):void {
        if (v != _value) {
            _value = v;
            dispatchEvent(new Event("valueChange"));
        }
    }

    public function get editable():Boolean {
        return _editable;
    }

    [Bindable("editableChange")]
    public function set editable(v:Boolean):void {
        if (v != _editable) {
            _editable = v;
            dispatchEvent(new Event("editableChange"));
        }
    }

    public function get format():String {
        if (_format == null) {
            _format = detectFormat(name, type);
        }
        return _format;
    }

    public function set format(v:String):void {
        if (v != "") {
            _format = v;
        }
    }

    public function get type():String {
        if (_type == null) {
            _type = detectType(value);
        }
        return _type;
    }

    public function set type(v:String):void {
        if (v != "") {
            _type = v;
        }
    }

    public function get enumeration():String {
        return _enumeration;
    }

    public function set enumeration(v:String):void {
        _enumeration = v;
    }

    protected function getArrayDisplayValue(array:Array):String {
        var result:Array = new Array();
        for each (var item:Object in array) {
            result.push(getItemDisplayValue(item));
        }
        return result.join(", ");
    }

    protected function getItemDisplayValue(item:*):String {
        if (item == null) { // works for both undefined and null values
            return "";
        }

        if (type == "Class") {
            return Utils.formatClass(item);
        } else if (item is EdgeMetrics) {
            var em:EdgeMetrics = EdgeMetrics(item);
            return "EdgeMetrics(left=" + em.left + ", top=" + em.top + ", right=" + em.right + ", bottom=" + em.bottom + ")";
        } else if (item is Rectangle) {
            var r:Rectangle = Rectangle(item);
            return "Rectange(x=" + r.x + ", y=" + r.y + ", width=" + r.width + ", height=" + r.height + ")";
        } else if (item is DisplayObject) {
            var className:String = getQualifiedClassName(item);
            return Utils.formatDisplayObject(DisplayObject(item), className);
        }

        // Default behavior
        return item.toString();
    }

    protected function detectType(value:Object):String {
        var result:String;
        if (value != null) {
            return getQualifiedClassName(value);
        }
        return "Undefined";
    }

    protected function detectFormat(name:String, type:String):String {
        // Unknown
        return "Undefined";
    }
}
}