/**
 * FlexSpy 1.4-beta
 *
 * <p>Code released under WTFPL [http://sam.zoy.org/wtfpl/]</p>
 * @author Arnaud Pichery [http://coderpeon.ovh.org]
 * @author Frédéric Thomas
 */
package com.flexspy.impl {
import flash.events.MouseEvent;

import mx.containers.Canvas;
import mx.controls.Image;
import mx.controls.Label;
import mx.core.ScrollPolicy;

public class PropertyDataGridValueRenderer extends Canvas {

    protected var valueLabel:Label;
    protected var editButton:Image;

    /**
     * Constructor
     */
    public function PropertyDataGridValueRenderer() {
        this.horizontalScrollPolicy = ScrollPolicy.OFF;
        this.verticalScrollPolicy = ScrollPolicy.OFF;
    }

    protected function onClickEditButton(event:MouseEvent):void {
        IPropertyEditor(owner.parent).editSelectedCell();
    }

    public override function set data(value:Object):void {
        super.data = value;

        if (value != null) {
            var item:PropertyEditorItem = PropertyEditorItem(value);
            valueLabel.text = item.displayValue;
            editButton.visible = item.editable;
        } else {
            valueLabel.text = "";
            editButton.visible = false;
        }
    }

    protected override function createChildren():void {
        super.createChildren();
        if (valueLabel == null) {
            valueLabel = new Label();
            valueLabel.minWidth = 0;
            valueLabel.setStyle("left", 2);
            valueLabel.setStyle("top", 0);
            valueLabel.setStyle("right", 15);
            valueLabel.setStyle("bottom", 0);
            this.addChild(valueLabel);
        }

        if (editButton == null) {
            editButton = new Image();
            editButton.source = Icons.EDIT;
            editButton.width = 9;
            editButton.height = 9;
            editButton.addEventListener(MouseEvent.CLICK, onClickEditButton);
            editButton.setStyle("top", 2);
            editButton.setStyle("right", 4);
            this.addChild(editButton);
        }
    }
}
}