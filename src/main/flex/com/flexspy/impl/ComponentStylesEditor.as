/**
 * FlexSpy 1.4-beta
 *
 * <p>Code released under WTFPL [http://sam.zoy.org/wtfpl/]</p>
 * @author Arnaud Pichery [http://coderpeon.ovh.org]
 * @author Frédéric Thomas
 */
package com.flexspy.impl {

import com.flexspy.impl.metadata.FrameworkMetadata;
import com.flexspy.impl.metadata.StyleMetadata;

import flash.events.Event;

import mx.collections.ArrayCollection;
import mx.collections.Sort;
import mx.collections.SortField;
import mx.containers.HBox;
import mx.containers.VBox;
import mx.controls.DataGrid;
import mx.controls.Text;
import mx.controls.TextInput;
import mx.controls.dataGridClasses.DataGridColumn;
import mx.core.ClassFactory;
import mx.events.CollectionEvent;
import mx.events.CollectionEventKind;
import mx.events.PropertyChangeEvent;
import mx.events.PropertyChangeEventKind;
import mx.styles.IStyleClient;

public class ComponentStylesEditor extends VBox implements IPropertyEditor {
    private var _unfilteredComponentProperties:Array;
    private var _componentTable:DataGrid;
    private var _filter:String;

    private var _currentObject:IStyleClient;
    private var _currentEditor:EditorClassFactory;

    /**
     * Initializes a new instance of this class
     */
    public function ComponentStylesEditor() {
        super();

        // properties
        this.label = "Styles";
        this.setStyle("paddingLeft", 10);
        this.setStyle("paddingRight", 10);
        this.setStyle("paddingBottom", 10);
    }

    /**
     * @private
     **/
    override protected function createChildren():void {
        super.createChildren();

        // Filter box
        var filterBox:HBox = new HBox();

        var uiText:Text = new Text();
        uiText.text = "Filter";
        filterBox.addChild(uiText);

        var filterTextInput:TextInput = new TextInput();
        filterTextInput.addEventListener("change", updateFilter);
        filterBox.addChild(filterTextInput);
        this.addChild(filterBox);

        // Component table
        _currentEditor = new EditorClassFactory();
        _currentEditor.activeInstance = new DataGridValueEditor();

        var col1:DataGridColumn = new DataGridColumn();
        col1.width = 160;
        col1.headerText = "Style";
        col1.dataField = "name";
        col1.editable = false;

        var col2:DataGridColumn = new DataGridColumn();
        col2.headerText = "Value";
        col2.dataField = "value";
        col2.editable = false;
        col2.editorDataField = "editedValue";
        col2.itemRenderer = new ClassFactory(StyleDataGridValueRenderer);
        col2.itemEditor = _currentEditor;

        _componentTable = new EditableDataGrid();
        _componentTable.percentWidth = 100.0;
        _componentTable.percentHeight = 100.0;
        _componentTable.columns = [col1, col2];
        this.addChild(_componentTable);
    }

    /**
     * Starts the edition of the currently selected cell.
     */
    public function editSelectedCell():void {
        var rowIndex:int = _componentTable.selectedIndex;
        var collection:ArrayCollection = _componentTable.dataProvider as ArrayCollection;
        var item:PropertyEditorItem = PropertyEditorItem(collection.getItemAt(rowIndex));

        var type:String = item.type;
        if (type == "String" && item.enumeration != "") {
            // Combobox.
            var enumerationEditor:DataGridValueEnumEditor = new DataGridValueEnumEditor();
            enumerationEditor.enumaration = item.enumeration;
            enumerationEditor.editedValue = item.value;

            _currentEditor.activeInstance = enumerationEditor;
        } else if (type == "Boolean") {
            var booleanEditor:DataGridValueBooleanEditor = new DataGridValueBooleanEditor();
            booleanEditor.editedValue = item.value;
            _currentEditor.activeInstance = booleanEditor;
        } else {
            _currentEditor.activeInstance = new DataGridValueEditor();
        }
        _componentTable.editedItemPosition = {columnIndex: 1, rowIndex: rowIndex};
    }

    public function showComponentStyles(displayObject:Object):void {
        // First remove all fields.
        _unfilteredComponentProperties = [];
        _currentObject = displayObject as IStyleClient;
        if (_currentObject != null) {
            addObjectProperties(_currentObject);
        }
        updateTableContent();
    }

    private function addObjectProperties(stylableObject:IStyleClient):void {
        var attributeList:Array = [];
        var property:PropertyEditorItem;
        var style:String;

        var stylesMetadata:Array = FrameworkMetadata.getClassStyles(stylableObject);
        if (stylesMetadata.length > 0) {
            for each (var styleMetadata:StyleMetadata in stylesMetadata) {
                property = createPropertyEditorItem(stylableObject, styleMetadata);
                if (property != null) {
                    attributeList.push(property.name);
                    _unfilteredComponentProperties.push(property);
                }
            }
        } else {
            // Metadata not found for this component. Show all possible styles (non editable)
            var nonInheritingStyles:Object = stylableObject.nonInheritingStyles;
            if (nonInheritingStyles != null) {
                for (style in nonInheritingStyles) {
                    property = inspectStyle(stylableObject, style, nonInheritingStyles, attributeList, false);
                    if (property != null) {
                        attributeList.push(property.name);
                        _unfilteredComponentProperties.push(property);
                    }
                }
            }

            var inheritingStyles:Object = stylableObject.inheritingStyles;
            if (inheritingStyles != null) {
                for (style in inheritingStyles) {
                    property = inspectStyle(stylableObject, style, inheritingStyles, attributeList, true);
                    if (property != null) {
                        attributeList.push(property.name);
                        _unfilteredComponentProperties.push(property);
                    }
                }
            }
        }
    }

    private static function filterList(source:Array, filter:String):Array {
        var filteredArray:Array = [];
        var pattern:String = (filter == null || filter.length == 0) ? null : filter.toLocaleLowerCase();

        for each (var property:PropertyEditorItem in source) {
            var propName:String = property.name;
            if (pattern == null || propName.toLocaleLowerCase().indexOf(pattern) >= 0) {
                filteredArray.push(property);
            }
        }
        return filteredArray;
    }

    private static function createPropertyEditorItem(stylableObject:IStyleClient, style:StyleMetadata):PropertyEditorItem {
        var attribute:PropertyEditorItem = new StyleEditorItem(style.name);
        attribute.value = stylableObject.getStyle(style.name);
        attribute.format = style.format;
        attribute.type = style.type;
        attribute.enumeration = style.enumeration;
        attribute.editable = (attribute.type == "Number" || attribute.type == "String" || attribute.type == "int" || attribute.type == "uint" || attribute.type == "Boolean");
        return attribute;
    }

    private static function inspectStyle(stylableObject:IStyleClient, name:String, styles:Object, attributeList:Array, inherited:Boolean):PropertyEditorItem {
        if (name == null || name.length == 0 || name.charAt(0) == '$' || attributeList.indexOf(name) >= 0) {
            // Invalid or private style, or already present (method might return several times the same properties)
            return null;
        }

        var attribute:PropertyEditorItem = new StyleEditorItem(name);
        attribute.value = styles[name];
        attribute.editable = false;
        return attribute;
    }


    private function updateFilter(event:Event):void {
        _filter = TextInput(event.target).text;
        updateTableContent();
    }

    private function updateTableContent():void {
        var array:Array = filterList(_unfilteredComponentProperties, _filter);
        var collection:ArrayCollection = new ArrayCollection(array);
        collection.addEventListener(CollectionEvent.COLLECTION_CHANGE, onCollectionChange, false, 0, true);
        var oldCollection:ArrayCollection = _componentTable.dataProvider as ArrayCollection;
        if (oldCollection != null) {
            collection.sort = oldCollection.sort;
        } else {
            var sort:Sort = new Sort();
            sort.fields = [ new SortField("name", true) ];
            collection.sort = sort;
        }
        collection.refresh();
        _componentTable.dataProvider = collection;
    }

    private function onCollectionChange(event:CollectionEvent):void {
        if (_currentObject != null && event.kind == CollectionEventKind.UPDATE) {
            var items:Array = event.items;
            for (var i:int = 0; i < items.length; i++) {
                var item:PropertyChangeEvent = items[i] as PropertyChangeEvent;
                if (item != null && item.kind == PropertyChangeEventKind.UPDATE) {
                    var attribute:Object = item.source;
                    changeItemValue(attribute.name, null, attribute.value);
                }
            }
        }
    }

    /**
     * Changes the value of the specified property
     *
     * @param name Name of the property to change
     * @param uri Qualifier of the name of the property (optional)
     * @param value New value of the property
     */
    public function changeItemValue(name:String, uri:String, value:*):void {
        _currentObject.setStyle(name, value);
    }
}
}