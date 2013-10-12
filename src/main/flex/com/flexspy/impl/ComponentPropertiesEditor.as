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
import flash.utils.describeType;
import flash.utils.getQualifiedClassName;

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

public class ComponentPropertiesEditor extends VBox implements IPropertyEditor {

    private var _unfilteredComponentProperties:Array;
    private var _componentProperties:ArrayCollection = new ArrayCollection();
    private var _componentTable:DataGrid;
    private var _filter:String;
    private var _currentEditor:EditorClassFactory;
    private var _currentObject:DisplayObject;
    private static var FILTERED_PROPERTIES:Array = ["textSnapshot", "accessibilityImplementation", "accessibilityProperties", "automationDelegate", "automationValue", "automationTabularData", "numAutomationChildren", "contextMenu", "focusManager", "styleDeclaration", "systemManager", "descriptor", "rawChildren", "verticalScrollBar", "horizontalScrollBar", "stage", "graphics", "focusPane", "loaderInfo", "moduleFactory", "transform", "soundTransform", "inheritingStyles", "nonInheritingStyles" ];

    /**
     * Initializes a new instance of this class
     */
    public function ComponentPropertiesEditor() {
        super();

        // properties
        this.label = "Properties";
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
        col1.headerText = "Property";
        col1.dataField = "displayName";
        col1.editable = false;
        col1.itemRenderer = new ClassFactory(DataGridNameRenderer);

        var col2:DataGridColumn = new DataGridColumn();
        col2.headerText = "Value";
        col2.dataField = "value";
        col2.editable = false;
        col2.editorDataField = "editedValue";
        col2.itemRenderer = new ClassFactory(PropertyDataGridValueRenderer);
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
        if (type == "String" && item.enumeration != "" && item.enumeration != null) {
            // Enumeration
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

    public function showComponentProperties(displayObject:DisplayObject):void {
        // First remove all fields.
        _unfilteredComponentProperties = new Array();

        _currentObject = displayObject;
        if (_currentObject != null) {
            addObjectProperties(-1, _currentObject);
        }
        updateTableContent();
    }

    private function addObjectProperties(index:int, displayObject:Object):void {
        var description:XML = describeType(displayObject);

        var attributeList:Array = new Array();
        var property:PropertyEditorItem;

        for each (var accessor:XML in description.accessor) {
            property = inspectXMLProperty(accessor, displayObject, attributeList);
            if (property != null) {
                attributeList.push(property.name);
                _unfilteredComponentProperties.push(property);
            }
        }
        for each (var variable:XML in description.variable) {
            property = inspectXMLProperty(variable, displayObject, attributeList);
            if (property != null) {
                attributeList.push(property.name);
                _unfilteredComponentProperties.push(property);
            }
        }
        for (var name:String in displayObject) {
            property = inspectProperty(name, null, getQualifiedClassName(displayObject[name]), displayObject, attributeList, "readonly");
            if (property != null) {
                attributeList.push(property.name);
                _unfilteredComponentProperties.push(property);
            }
        }
    }

    private function filterList(source:Array, filter:String):Array {
        var filteredArray:Array = new Array();
        var pattern:String = (filter == null || filter.length == 0) ? null : filter.toLowerCase();

        for each (var property:PropertyEditorItem in source) {
            if (pattern == null || property.name.toLowerCase().indexOf(pattern) >= 0) {
                filteredArray.push(property);
            }
        }
        return filteredArray;
    }

    private function inspectXMLProperty(property:XML, displayObject:Object, attributeList:Array):PropertyEditorItem {
        //trace("inspecting property " + property.@name);
        if (property.@access == "writeonly") {
            return null;
        }
        return inspectProperty(property.@name, property.@uri, property.@type, displayObject, attributeList, property.@access);
    }

    private function inspectProperty(name:String, ns:String, type:String, displayObject:Object, attributeList:Array, access:String):PropertyEditorItem {
        if (name == null || name.length == 0 || name.charAt(0) == '$' || attributeList.indexOf(name) >= 0 || FILTERED_PROPERTIES.indexOf(name) >= 0) {
            // Invalid or private property, or already present (describeType method might return several times the same properties)
            return null;
        }

        var attribute:PropertyEditorItem = new PropertyEditorItem(name);
        attribute.type = type;
        attribute.uri = ns;
        try {
            attribute.value = getObjectPropertyValue(displayObject, name, ns);
            attribute.editable = ((access != "readonly") && (Utils.isSafeType(type) || Utils.isSafeType(getQualifiedClassName(attribute.value))));
        } catch (error:ReferenceError) {
            // Unable to retrieve property value.
            trace("Failed to retrieve value for property " + name + ": " + error.message);
            attribute.value = "[Unable to retrieve value]";
            attribute.editable = false;
        }
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
            sort.fields = [ new SortField("displayName", true) ];
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
                    var attribute:PropertyEditorItem = PropertyEditorItem(item.source);
                    changeItemValue(attribute.name, attribute.uri, attribute.value);
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
        setObjectPropertyValue(_currentObject, name, uri, value);
    }

    private static function setObjectPropertyValue(object:Object, propertyName:String, namespaceUri:String, value:*):void {
        if (namespaceUri == null || namespaceUri == "") {
            object[propertyName] = value;
        } else {
            var ns:Namespace = new Namespace(namespaceUri);
            object.ns::[propertyName] = value;
        }
    }

    private static function getObjectPropertyValue(object:Object, propertyName:String, namespaceUri:String):* {
        if (namespaceUri == null || namespaceUri == "") {
            return object[propertyName];
        } else {
            var ns:Namespace = new Namespace(namespaceUri);
            return object.ns::[propertyName];
        }
    }
}
}