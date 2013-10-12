/**
 * FlexSpy 1.4-beta
 *
 * <p>Code released under WTFPL [http://sam.zoy.org/wtfpl/]</p>
 * @author Arnaud Pichery [http://coderpeon.ovh.org]
 * @author Frédéric Thomas
 */
package com.flexspy.impl {

import mx.skins.Border;

public class ComponentTreeChrome implements IComponentTreeItem {

    private var _children:Array;
    private var _parent:IComponentTreeItem;

    public function ComponentTreeChrome(kids:Array, parent:IComponentTreeItem) {
        _children = kids;
        _parent = parent;
    }

    /**
     *  The label of the item.
     */
    public function get label():String {
        return "Chrome";
    }

    /**
     *  The icon for the item.
     */
    public function get icon():Class {
        return ComponentIcons.Chrome;
    }

    /**
     *  The children of this item.
     */
    public function get children():Array {
        return _children;
    }

    /**
     *  The parent of the item.
     */
    public function get parent():IComponentTreeItem {
        return _parent;
    }

    /**
     * Gets the child component that intersects with the supplied stage coordinate
     */
    public function getHitComponent(x:Number, y:Number, includeChrome:Boolean):ComponentTreeItem {
        var borderResult:ComponentTreeItem = null;
        for each (var item:IComponentTreeItem in children) {
            if (item is ComponentTreeItem) {
                var result:ComponentTreeItem = ComponentTreeItem(item).getHitComponent(x, y, includeChrome);
                if (result != null) {
                    if (ComponentTreeItem(item).displayObject is Border) {
                        // Try to find a best candidate than a border.
                        borderResult = result;
                    } else {
                        return result;
                    }
                }
            } else if (includeChrome && (item is ComponentTreeChrome)) {
                var resultChrome:ComponentTreeItem = ComponentTreeChrome(item).getHitComponent(x, y, includeChrome);
                if (resultChrome != null) {
                    return resultChrome;
                }
            }
        }
        return borderResult;
    }
}
}