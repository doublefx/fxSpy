/**
 * FlexSpy 1.4-beta
 *
 * <p>Code released under WTFPL [http://sam.zoy.org/wtfpl/]</p>
 * @author Arnaud Pichery [http://coderpeon.ovh.org]
 * @author Frédéric Thomas
 */
package com.flexspy.impl {
import flash.events.Event;
import flash.events.MouseEvent;

import mx.controls.ColorPicker;
import mx.events.ColorPickerEvent;
import mx.events.FlexEvent;

public class StyleDataGridValueRenderer extends PropertyDataGridValueRenderer {

    protected var colorPicker:ColorPicker;

    /**
     * Constructor
     */
    public function StyleDataGridValueRenderer() {
        super();
        this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
    }

    protected override function onClickEditButton(event:MouseEvent):void {
        var item:PropertyEditorItem = PropertyEditorItem(data);
        if (colorPicker != null && colorPicker.visible) {
            colorPicker.open();
        } else {
            super.onClickEditButton(event);
        }
    }

    public override function set data(value:Object):void {
        super.data = value;
        updateButtonStates(PropertyEditorItem(value));
    }

    private function onCreationComplete(event:Event):void {
        updateButtonStates(PropertyEditorItem(data));
    }

    private function updateButtonStates(item:PropertyEditorItem):void {
        if (editButton == null || colorPicker == null)
            return; // child controls not created yet.

        if (item != null && item.editable) {
            if (item != null && item.format == "Color" && item.type != "Array") {
                colorPicker.visible = true;
                colorPicker.selectedColor = uint(item.value);
                valueLabel.setStyle("left", 22);
            } else {
                colorPicker.visible = false;
                valueLabel.setStyle("left", 2);
            }
        } else {
            colorPicker.visible = false;
            valueLabel.setStyle("left", 2);
        }
    }

    private function onSelectedColorChange(event:Event):void {
        var item:PropertyEditorItem = PropertyEditorItem(data);
        item.value = colorPicker.selectedColor;

        // Update label
        valueLabel.text = data.displayValue;

        // Update underlying style
        IPropertyEditor(owner.parent).changeItemValue(item.name, null, item.value);
    }

    protected override function createChildren():void {
        super.createChildren();
        if (colorPicker == null) {
            colorPicker = new ColorPicker();
            colorPicker.width = 16;
            colorPicker.height = 16;
            colorPicker.setStyle("left", 4);
            colorPicker.setStyle("top", 0);
            colorPicker.addEventListener(ColorPickerEvent.CHANGE, onSelectedColorChange);
            this.addChild(colorPicker);
        }
    }
}
}