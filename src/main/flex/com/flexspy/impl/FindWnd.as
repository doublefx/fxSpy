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
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Point;

import mx.containers.TitleWindow;
import mx.controls.Button;
import mx.controls.Label;
import mx.effects.Effect;
import mx.effects.Glow;
import mx.managers.CursorManager;
import mx.managers.CursorManagerPriority;
import mx.managers.PopUpManager;

/**
 * Window to find a component using a dragable target
 */
public class FindWnd extends TitleWindow {

    [Embed(source="../../../../resources/assets/Target.png")]
    public static var TARGET_ICON:Class;

    public var treeWnd:ComponentTreeWnd;

    private static const DRAG_ALPHA:Number = 0.6;

    // Members
    private var _cursorId:int;
    private var _componentItem:ComponentTreeItem;
    private var _highlightComponentEffect:Effect;
    private var _defaultAlpha:Number;

    // Components
    private var dragButton:Button;
    private var coordinatesLabel:Label;
    private var componentLabel:Label;
    private var highlightRectangle:HighlightRectangle;

    /**
     * This method is not intended to be used. Use <code>show</code> method instead.
     */
    public function FindWnd() {
        super();

        // properties
        this.layout = "absolute";
        this.title = "Find Component";
        this.width = 342;
        this.height = 144;
        this.showCloseButton = true;
        this.horizontalScrollPolicy = "off";
        this.verticalScrollPolicy = "off";

        // events
        this.addEventListener("close", closeWindow);
        this.addEventListener(KeyboardEvent.KEY_UP, onKeyPressed);
    }

    override protected function createChildren():void {
        super.createChildren();

        if (dragButton == null) {
            dragButton = new Button();
            dragButton.x = 10;
            dragButton.y = 10;
            dragButton.label = "Drag me";
            dragButton.width = 96;
            dragButton.height = 34;
            dragButton.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            dragButton.setStyle("icon", TARGET_ICON);
            this.addChild(dragButton);
        }

        if (componentLabel == null) {
            componentLabel = new Label();
            componentLabel.setStyle("left", 10);
            componentLabel.setStyle("right", 10);
            componentLabel.y = 52;
            this.addChild(componentLabel);
        }

        if (coordinatesLabel == null) {
            coordinatesLabel = new Label();
            coordinatesLabel.setStyle("left", 10);
            coordinatesLabel.setStyle("right", 10);
            coordinatesLabel.y = 78;
            this.addChild(coordinatesLabel);
        }
    }

    private function onKeyPressed(event:KeyboardEvent):void {
        if (event.keyCode == 27) { // 27 = ESC key
            closeWindow();
        }
    }

    private function closeWindow(event:Event = null):void {
        PopUpManager.removePopUp(this);
        treeWnd.visible = true;
    }

    private function onMouseDown(event:MouseEvent):void {
        systemManager.addEventListener(MouseEvent.MOUSE_MOVE, onCaptureMouseMove, true);
        systemManager.addEventListener(MouseEvent.MOUSE_UP, onCaptureMouseUp, true);
        _cursorId = CursorManager.setCursor(TARGET_ICON, CursorManagerPriority.HIGH, -9, -9);
        dragButton.setStyle("icon", null);
        dragButton.enabled = false;

        highlightRectangle = new HighlightRectangle();
        highlightRectangle.setActualSize(50, 50);
        highlightRectangle.move(10, 50);
        var i:int = systemManager.getChildIndex(this);
        systemManager.addChildAt(highlightRectangle, i);

        _defaultAlpha = this.alpha;
        this.alpha = DRAG_ALPHA;
    }

    private function onCaptureMouseUp(event:MouseEvent):void {
        // Stop spying
        this.alpha = _defaultAlpha;
        systemManager.removeEventListener(MouseEvent.MOUSE_MOVE, onCaptureMouseMove, true);
        systemManager.removeEventListener(MouseEvent.MOUSE_UP, onCaptureMouseUp, true);
        CursorManager.removeCursor(_cursorId);
        systemManager.removeChild(highlightRectangle);
        dragButton.setStyle("icon", TARGET_ICON);
        dragButton.enabled = true;

        PopUpManager.removePopUp(this);
        treeWnd.visible = true;
        treeWnd.selectComponentAt(event.stageX, event.stageY);
    }

    private function onCaptureMouseMove(event:MouseEvent):void {
        coordinatesLabel.text = "(" + event.stageX + ", " + event.stageY + ")";

        var componentItem:ComponentTreeItem = treeWnd.getComponentItemAt(event.stageX, event.stageY);
        if (_componentItem != componentItem) {
            _componentItem = componentItem;

            if (_componentItem != null) {
                highlightComponent(componentItem);
                componentLabel.text = componentItem.label;
            } else {
                componentLabel.text = "";
            }
        }
    }

    private function highlightComponent(componentItem:ComponentTreeItem):void {
        highlightComponentEffect.end();
        if (_componentItem.displayObject != null) {
            highlightComponentEffect.target = _componentItem.displayObject;
            highlightComponentEffect.play();

            var componentForSize:DisplayObject = getComponentForSize(_componentItem);
            if (componentForSize != null) {
                var coord:Point = componentForSize.localToGlobal(new Point(0, 0));
                highlightRectangle.visible = true;
                highlightRectangle.width = componentForSize.width;
                highlightRectangle.height = componentForSize.height;
                highlightRectangle.x = coord.x;
                highlightRectangle.y = coord.y;
                highlightRectangle.invalidateSize();
                highlightRectangle.invalidateDisplayList();
            } else {
                highlightRectangle.visible = false;
            }
        }

    }

    private static function getComponentForSize(componentItem:ComponentTreeItem):DisplayObject {
        var item:ComponentTreeItem = componentItem;
        while (item != null && (item.displayObject == null || item.displayObject.width == 0 || item.displayObject.height == 0)) {
            var itemParent:IComponentTreeItem = item.parent;
            while (itemParent != null && ((itemParent as ComponentTreeItem) == null)) {
                itemParent = itemParent.parent;
            }
            item = ComponentTreeItem(itemParent);
        }
        return (item == null) ? null : item.displayObject;
    }

    private function get highlightComponentEffect():Effect {
        if (_highlightComponentEffect == null) {
            var glow:Glow = new Glow();
            glow.color = 0xFFFF00;
            glow.strength = 10;
            glow.inner = false;
            glow.duration = 250;
            _highlightComponentEffect = glow;
        }
        return _highlightComponentEffect;
    }
}
}