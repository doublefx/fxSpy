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

import mx.core.IChildList;
import mx.core.IRawChildrenContainer;
import mx.core.UIComponent;

public class ComponentTreeItem implements IComponentTreeItem {
    private var _displayObject:DisplayObject;
    private var _label:String;
    private var _children:Array;
    private var _childrenComputed:Boolean;
    private var _propertiesComputed:Boolean;
    private var _icon:Class;
    private var _parent:IComponentTreeItem;

    /**
     * Creates a new instance of this class.
     */
    public function ComponentTreeItem(displayObj:DisplayObject, parent:IComponentTreeItem) {
        if (displayObj == null)
            throw new Error("displayOjbect argument cannot be null");

        _displayObject = displayObj;
        _parent = parent;
    }

    /**
     *  The underlying DisplayObject represented by this item.
     */
    public function get displayObject():DisplayObject {
        return _displayObject;
    }

    /**
     *  The label of the item.
     */
    public function get label():String {
        if (!_propertiesComputed) {
            computeProperties();
        }
        return _label;
    }

    /**
     *  The icon for the item.
     */
    public function get icon():Class {
        if (!_propertiesComputed) {
            computeProperties();
        }
        return _icon;
    }

    /**
     *  The children of this item.
     */
    public function get children():Array {
        if (!_childrenComputed) {
            _children = computeChildren();
            _childrenComputed = true;
        }
        return _children;
    }

    /**
     *  The parent of the item.
     */
    public function get parent():IComponentTreeItem {
        return _parent;
    }

    /**
     * Computes the label & icon for this item from the
     * underlying DisplayObject
     */
    private function computeProperties():void {
        // Compute label
        var className:String = getQualifiedClassName(displayObject);
        _label = Utils.formatDisplayObject(displayObject, className);

        // Compute icon
        switch (className) {
            case "mx.containers::Accordion":
                _icon = ComponentIcons.Accordion;
                break;
            case "mx.containers::ApplicationControlBar":
                _icon = ComponentIcons.ApplicationControlBar;
                break;
            case "mx.containers::Box":
                _icon = ComponentIcons.Box;
                break;
            case "mx.containers::Canvas":
                _icon = ComponentIcons.Canvas;
                break;
            case "mx.containers::ControlBar":
                _icon = ComponentIcons.ControlBar;
                break;
            case "mx.containers::DividedBox":
                _icon = ComponentIcons.DividedBox;
                break;
            case "mx.containers::Form":
                _icon = ComponentIcons.Form;
                break;
            case "mx.containers::FormHeading":
                _icon = ComponentIcons.FormHeading;
                break;
            case "mx.containers::FormItem":
                _icon = ComponentIcons.FormItem;
                break;
            case "mx.containers::Grid.":
                _icon = ComponentIcons.Grid;
                break;
            case "mx.containers::HBox":
                _icon = ComponentIcons.HBox;
                break;
            case "mx.containers::HDividedBox":
                _icon = ComponentIcons.HDividedBox;
                break;
            case "mx.containers::Panel":
                _icon = ComponentIcons.Panel;
                break;
            case "mx.containers::TabNavigator":
                _icon = ComponentIcons.TabNavigator;
                break;
            case "mx.containers::Tile":
                _icon = ComponentIcons.Tile;
                break;
            case "mx.containers::TitleWindow":
                _icon = ComponentIcons.TitleWindow;
                break;
            case "mx.containers::VBox":
                _icon = ComponentIcons.VBox;
                break;
            case "mx.containers::VDividedBox":
                _icon = ComponentIcons.VDividedBox;
                break;
            case "mx.containers::ViewStack":
                _icon = ComponentIcons.ViewStack;
                break;
            case "mx.charts::AreaChart":
                _icon = ComponentIcons.AreaChart;
                break;
            case "mx.charts::BarChart":
                _icon = ComponentIcons.BarChart;
                break;
            case "mx.charts::BubbleChart":
                _icon = ComponentIcons.BubbleChart;
                break;
            case "mx.charts::CandlestickChart":
                _icon = ComponentIcons.CandlestickChart;
                break;
            case "mx.charts::ColumnChart":
                _icon = ComponentIcons.ColumnChart;
                break;
            case "mx.charts::HLOCChart":
                _icon = ComponentIcons.HLOCChart;
                break;
            case "mx.charts::Legend":
                _icon = ComponentIcons.Legend;
                break;
            case "mx.charts::LineChart":
                _icon = ComponentIcons.LineChart;
                break;
            case "mx.charts::PieChart":
                _icon = ComponentIcons.PieChart;
                break;
            case "mx.charts::PlotChart":
                _icon = ComponentIcons.PlotChart;
                break;
            case "mx.controls::Button":
                _icon = ComponentIcons.Button;
                break;
            case "mx.controls::CheckBox":
                _icon = ComponentIcons.CheckBox;
                break;
            case "mx.controls::ColorPicker":
                _icon = ComponentIcons.ColorPicker;
                break;
            case "mx.controls::ComboBox":
                _icon = ComponentIcons.ComboBox;
                break;
            case "mx.controls::DataGrid":
                _icon = ComponentIcons.DataGrid;
                break;
            case "mx.controls::DateChooser":
                _icon = ComponentIcons.DateChooser;
                break;
            case "mx.controls::DateField":
                _icon = ComponentIcons.DateField;
                break;
            case "mx.controls::HorizontalList":
                _icon = ComponentIcons.HorizontalList;
                break;
            case "mx.controls::HRule":
                _icon = ComponentIcons.HRule;
                break;
            case "mx.controls::HScrollBar":
                _icon = ComponentIcons.HScrollBar;
                break;
            case "mx.controls::HSlider":
                _icon = ComponentIcons.HSlider;
                break;
            case "mx.controls::Image":
                _icon = ComponentIcons.Image;
                break;
            case "mx.controls::Label":
                _icon = ComponentIcons.Label;
                break;
            case "mx.controls::LinkBar":
                _icon = ComponentIcons.LinkBar;
                break;
            case "mx.controls::LinkButton":
                _icon = ComponentIcons.LinkButton;
                break;
            case "mx.controls::List":
                _icon = ComponentIcons.List;
                break;
            case "mx.controls::Menu":
                _icon = ComponentIcons.Menu;
                break;
            case "mx.controls::MenuBar":
                _icon = ComponentIcons.MenuBar;
                break;
            case "mx.controls::NumericStepper":
                _icon = ComponentIcons.NumericStepper;
                break;
            case "mx.controls::ProgressBar":
                _icon = ComponentIcons.ProgressBar;
                break;
            case "mx.controls::RadioButton":
                _icon = ComponentIcons.RadioButton;
                break;
            case "mx.controls::RadioButtonGroup":
                _icon = ComponentIcons.RadioButtonGroup;
                break;
            case "mx.controls::RichTextEditor":
                _icon = ComponentIcons.RichTextEditor;
                break;
            case "mx.controls::Spacer":
                _icon = ComponentIcons.Spacer;
                break;
            case "mx.controls::SWFLoader":
                _icon = ComponentIcons.SWFLoader;
                break;
            case "mx.controls::TabBar":
                _icon = ComponentIcons.TabBar;
                break;
            case "mx.controls::Text":
                _icon = ComponentIcons.Text;
                break;
            case "mx.controls::TextArea":
                _icon = ComponentIcons.TextArea;
                break;
            case "mx.controls::TextInput":
                _icon = ComponentIcons.TextInput;
                break;
            case "mx.controls::TileList":
                _icon = ComponentIcons.TileList;
                break;
            case "mx.controls::Tree":
                _icon = ComponentIcons.Tree;
                break;
            case "mx.controls::VideoDisplay":
                _icon = ComponentIcons.VideoDisplay;
                break;
            case "mx.controls::VRule":
                _icon = ComponentIcons.VRule;
                break;
            case "mx.controls::VScrollBar":
                _icon = ComponentIcons.VScrollBar;
                break;
            case "mx.controls::VSlider":
                _icon = ComponentIcons.VSlider;
                break;
            default:
                _icon = ComponentIcons.Default;
                break;
        }
    }

    /**
     * Computes the children of this item.
     */
    public function computeChildren():Array {
        var component:UIComponent = displayObject as UIComponent;
        if (component == null)
            return null; // Only UIComponents have children.

        var children:Array = [];

        // Add the "standard" children
        for (var i:int = 0; i < component.numChildren; i++) {
            var child:DisplayObject = component.getChildAt(i);

            // Check that this child is not already present in the collection
            if (child != null && !containsChild(children, child)) {
                children.push(new ComponentTreeItem(child, this));
            }
        }

        // Add the "Chrome" children
        if (component is IRawChildrenContainer) {
            var childList:IChildList = IRawChildrenContainer(component).rawChildren;
            var chromeChildren:Array = [];
            var chromeItem:ComponentTreeChrome = new ComponentTreeChrome(chromeChildren, this);

            // Add the chrome children
            for (var k:int = 0; k < childList.numChildren; k++) {
                var kchild:DisplayObject = childList.getChildAt(k);

                // Check that this child is not already present in the collection
                if (!containsChild(children, kchild) && kchild != null) {
                    chromeChildren.push(new ComponentTreeItem(kchild, chromeItem));
                }
            }

            if (chromeChildren.length > 0) {
                children.push(chromeItem);
            }
        }
        return (children.length == 0) ? null : children;
    }

    /**
     * Indicates whether the specified DisplayObject is present in the given children collection
     */
    private static function containsChild(children:Array, displayObj:DisplayObject):Boolean {
        for each (var kid:IComponentTreeItem in children) {
            if (kid is ComponentTreeItem && ComponentTreeItem(kid).displayObject == displayObj) {
                return true;
            }
        }
        return false;
    }

    /**
     * Gets the child component that intersects with the supplied stage coordinate
     */
    public function getHitComponent(x:Number, y:Number, includeChrome:Boolean):ComponentTreeItem {
        if (_displayObject.visible && _displayObject.hitTestPoint(x, y, true)) {
            for each (var item:IComponentTreeItem in children) {
                if (item is ComponentTreeItem) {
                    var result:ComponentTreeItem = ComponentTreeItem(item).getHitComponent(x, y, includeChrome);
                    if (result != null) {
                        return result;
                    }
                } else if (includeChrome && (item is ComponentTreeChrome)) {
                    var resultChrome:ComponentTreeItem = ComponentTreeChrome(item).getHitComponent(x, y, includeChrome);
                    if (resultChrome != null) {
                        return resultChrome;
                    }
                }
            }
            // Not inside its children, return this component.
            return this;
        } else {
            return null;
        }
    }
}
}