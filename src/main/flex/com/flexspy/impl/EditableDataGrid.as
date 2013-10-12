/**
 * FlexSpy 1.4-beta
 *
 * <p>Code released under WTFPL [http://sam.zoy.org/wtfpl/]</p>
 * @author Arnaud Pichery [http://coderpeon.ovh.org]
 * @author Frédéric Thomas
 */
package com.flexspy.impl {

import flash.events.FocusEvent;

import mx.controls.DataGrid;
import mx.core.EventPriority;
import mx.events.DataGridEvent;
import mx.events.DataGridEventReason;

/**
 * DataGrid that does not try to restore the edited item when it re-gains the focus
 */
public class EditableDataGrid extends DataGrid {

    public function EditableDataGrid() {
        super();

        editable = true;
        addEventListener(DataGridEvent.ITEM_EDIT_BEGINNING, disableEditing);
        addEventListener(DataGridEvent.ITEM_EDIT_END, onItemEditEnd, false, EventPriority.DEFAULT);
    }

    /**
     *  @private
     *  when the grid gets focus, does not focus an item renderer
     */
    override protected function focusInHandler(event:FocusEvent):void {
        editable = false;
        super.focusInHandler(event);
        editable = true;
    }

    private static function onItemEditEnd(event:DataGridEvent):void {
        // Modify the event.
        if (event.reason == DataGridEventReason.NEW_ROW) {
            event.reason = DataGridEventReason.OTHER;
        }
    }

    private static function disableEditing(event:DataGridEvent):void {
        // Only the above method can trigger an edition.
        event.preventDefault();
    }
}
}