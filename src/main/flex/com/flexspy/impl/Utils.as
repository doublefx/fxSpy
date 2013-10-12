/**
 * FlexSpy 1.4-beta
 *
 * <p>Code released under WTFPL [http://sam.zoy.org/wtfpl/]</p>
 * @author Arnaud Pichery [http://coderpeon.ovh.org]
 * @author Frédéric Thomas
 */
package com.flexspy.impl {

import flash.display.DisplayObject;
import flash.utils.getQualifiedClassName;

import mx.core.UIComponent;
import mx.utils.StringUtil;

/**
 * Various utilities function used by FlexSpy.
 */
public class Utils {
    public static function toHexColor(n:Number):String {
        var result:String = n.toString(16);
        while (result.length < 6) {
            result = "0" + result;
        }
        return ("#" + result);
    }

    public static function fromHexColor(str:String):Number {
        if (str == null || str == "") {
            return 0;
        }
        if (str.charAt(0) == "#") {
            // Map "#77EE11" to 0x77EE11
            return Number("0x" + str.slice(1));
        }
        // Default
        return Number(str);
    }

    public static function isSafeType(type:String):Boolean {
        // Base types
        if (type == "Number" || type == "String" || type == "Boolean" || type == "int" || type == "uint" || type == "Date")
            return true;

        // Known types
        if (type == "flash.geom::Rectangle" || type == "mx.core::EdgeMetrics")
            return true;

        // Unknown types
        return false;
    }

    public static function endsWith(str:String, suffix:String, caseSensitive:Boolean = true):Boolean {
        if (suffix == null) {
            return true;
        }
        if (str == null) {
            return false;
        }
        var startIndex:int = str.length - suffix.length;
        if (startIndex < 0) {
            return false;
        }
        if (caseSensitive) {
            return (str.substr(startIndex) == suffix);
        } else {
            return (str.substr(startIndex).toLowerCase() == suffix.toLowerCase());
        }
    }

    public static function formatDisplayObject(displayObject:DisplayObject, className:String):String {
        if (displayObject == null)
            return "";

        var item:String = className;
        if (item.indexOf("::") >= 0) {
            item = item.substr(2 + item.indexOf("::"));
        }
        if (displayObject is UIComponent && (UIComponent(displayObject).id != null) && (UIComponent(displayObject).id != "")) {
            item += " id=\"" + UIComponent(displayObject).id + "\"";
        } else if (displayObject.name != null && displayObject.name != "") {
            item += " name=\"" + displayObject.name + "\"";
        }
        item = StringUtil.substitute("<{0}>", item);
        return item;
    }

    public static function formatClass(item:Object):String {
        var className:String = getQualifiedClassName(item);
        if (className != null) {
            var idx:int = className.indexOf("::");
            if (idx > 0) {
                return "ClassReference(\"" + className + "\")";
            }
        } else {
            className = String(item);
        }

        // Embeded resource, the pattern is [Class]__embed_css_[source]_[item]_[number]
        var EMBED_CSS:String = "__embed_css_";
        idx = className.indexOf(EMBED_CSS);
        if (idx > 0) {
            var embededInfo:String = className.substr(idx + EMBED_CSS.length);
            // Remove the trailing number
            embededInfo = embededInfo.substr(0, embededInfo.lastIndexOf("_"));

            var embededFile:String = embededInfo;
            var embededParam:String = "";
            idx = embededInfo.indexOf("_swf_");
            if (idx > 0) {
                embededFile = embededInfo.substr(0, idx) + ".swf";
                embededParam = embededInfo.substr(idx + 4);
                if (embededParam.length > 0) {
                    embededParam = embededParam.substr(1); // Remove the leading "_"
                    while (embededParam.indexOf("_") > 0) {
                        embededParam = embededParam.replace("_", ".");
                    }
                }
            } else {
                idx = embededInfo.lastIndexOf("_");
                if (idx > 0) {
                    embededFile = embededInfo.substr(0, idx) + "." + embededInfo.substr(idx + 1);
                }
            }

            if (embededParam.length > 0) {
                return "Embed(source=\"" + embededFile + "\", symbol=\"" + embededParam + "\")";
            } else {
                return "Embed(\"" + embededFile + "\")";
            }
        }
        return className;
    }
}
}