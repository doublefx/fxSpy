/**
 * FlexSpy 1.4-beta
 *
 * <p>Code released under WTFPL [http://sam.zoy.org/wtfpl/]</p>
 * @author Arnaud Pichery [http://coderpeon.ovh.org]
 * @author Frédéric Thomas
 */
package com.flexspy {

import com.flexspy.impl.ComponentTreeWnd;

import flash.display.DisplayObject;
import flash.events.KeyboardEvent;
import flash.external.ExternalInterface;

import mx.core.FlexGlobals;

/**
 * Entry point to use FlexSpy.
 */
public class FlexSpy {
    /**
     * Displays the tree of the specified DisplayObject (its children, the children of its children, etc.)
     *
     * @param root Root of the displayed tree. If it is null, the current application is used.
     * @param modal true to display a modal window (default), false to display a modeless window.
     * @param childList The PopUpManagerChildList you want the popup be added to, see mx.managers.PopUpManagerChildList
     */
    public static function show(root:DisplayObject = null, modal:Boolean = false, childList:String = null):void {
        ComponentTreeWnd.show(root, modal, childList);
    }

    /**
     * Registers a key sequence that will trigger the appearance of the FlexSpy window.
     *
     * @param key Sequence of keys to press to display the FlexSpy window.
     * @param root Root of the displayed tree. If set to <code>null</code> the root window
     * of the application is used.
     * @param modal true to display a modal window (default), false to display a modeless window.
     */
    public static function registerKey(key:KeySequence, root:DisplayObject = null, modal:Boolean = false):void {
        if (root == null) {
            root = DisplayObject(FlexGlobals.topLevelApplication);
        }

        root.addEventListener(KeyboardEvent.KEY_DOWN, function (event:KeyboardEvent):void {
            if (key.isPressed(event)) {
                show(root, modal);
            }
        });
    }

    /**
     * Registers an ActionScript method as callable from JavaScript in the container.
     *
     * @param root Root of the displayed tree. If set to <code>null</code> the root window
     * of the application is used.
     * @param modal true to display a modal window (default), false to display a modeless window.
     * @param functionName The JS function's name you want to show FlexSpy
     */
    public static function registerJS(root:DisplayObject = null, modal:Boolean = false, functionName:String = "flexSpy"):void {
        if (root == null) {
            root = DisplayObject(FlexGlobals.topLevelApplication);
        }

        if (ExternalInterface.available) {
            ExternalInterface.addCallback(functionName, function ():void {
                show(root, modal);
            });
        }
    }
}
}
