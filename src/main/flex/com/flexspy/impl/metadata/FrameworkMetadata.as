/**
 * FlexSpy 1.4-beta
 *
 * <p>Code released under WTFPL [http://sam.zoy.org/wtfpl/]</p>
 * @author Arnaud Pichery [http://coderpeon.ovh.org]
 * @author Frédéric Thomas
 */
package com.flexspy.impl.metadata {

import flash.utils.describeType;

/**
 * Query and manipulate metadata about styles and properties of components
 * in the Flex 2.01 Framework
 */
public class FrameworkMetadata {

    /**
     * Gets the style metadata defined for the class of the supplied object.
     *
     * @param component A non-null object representing an instance of a DisplayObject.
     * @return An array of <code>StyleMetadata</code> objects.
     */
    public static function getClassStyles(component:Object):Array {
        var result:Array = new Array();
        var typeDescription:XML = describeType(component);
        var qualifiedClassName:String = typeDescription.@name;
        qualifiedClassName = qualifiedClassName.replace("::", ".");
        var classHierarchy:XMLList = typeDescription.extendsClass.@type;

        var hierarchy:Array = new Array();
        hierarchy.push(qualifiedClassName);
        for each (var subClass:XML in classHierarchy) {
            var qualifiedSubClassName:String = subClass.toString().replace("::", ".");
            hierarchy.push(qualifiedSubClassName);
        }

        for each (var className:String in hierarchy) {
            var xmlClassStyleMetadata:XMLList = COMPONENTS.component.(@name == className).style;
            for each (var xmlStyleMetadata:XML in xmlClassStyleMetadata) {
                var styleMetadata:StyleMetadata = new StyleMetadata(xmlStyleMetadata);
                if (!containsStyleMetadata(result, styleMetadata.name)) {
                    result.push(styleMetadata);
                }
            }

        }
        return result;
    }

    /**
     * Gets a value indicating whether the supplied array contains a StyleMetaData with the
     * specified name
     */
    private static function containsStyleMetadata(array:Array, styleName:String):Boolean {
        for each (var styleMetadata:StyleMetadata in array) {
            if (styleMetadata.name == styleName) {
                return true;
            }
        }
        return false;
    }

    /** Metadata for components */
    private static var COMPONENTS:XML =
            <components>
                <component name="mx.charts.AxisRenderer" base="mx.charts.chartClasses.DualStyleObject">
                    <style name="axisStroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="axisTitleStyleName" inherit="yes" type="String"/>
                    <style name="canDropLabels" inherit="no" type="Boolean"/>
                    <style name="canStagger" inherit="no" type="Boolean"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="labelGap" inherit="no" format="Length" type="Number"/>
                    <style name="labelRotation" inherit="no" type="Number"/>
                    <style name="minorTickLength" inherit="no" format="Length" type="Number"/>
                    <style name="minorTickPlacement" inherit="no" enumeration="inside,outside,cross,none" type="String"/>
                    <style name="minorTickStroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="showLabels" inherit="no" type="Boolean"/>
                    <style name="showLine" inherit="no" type="Boolean"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="tickLength" inherit="no" format="Length" type="Number"/>
                    <style name="tickPlacement" inherit="no" enumeration="inside,outside,cross,none" type="String"/>
                    <style name="tickStroke" inherit="no" type="mx.graphics.IStroke"/>
                </component>
                <component name="mx.charts.BarChart" base="mx.charts.chartClasses.CartesianChart">
                    <style name="barWidthRatio" inherit="no" type="Number"/>
                    <style name="maxBarWidth" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.charts.BubbleChart" base="mx.charts.chartClasses.CartesianChart">
                    <style name="maxRadius" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.charts.CandlestickChart" base="mx.charts.chartClasses.CartesianChart">
                    <style name="columnWidthRatio" inherit="no" type="Number"/>
                    <style name="maxColumnWidth" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.charts.chartClasses.CartesianChart" base="mx.charts.chartClasses.ChartBase">
                    <style name="axisTitleStyleName" inherit="yes" type="String"/>
                    <style name="gridLinesStyleName" inherit="no" type="String"/>
                    <style name="gutterBottom" inherit="no" format="Length" type="Number"/>
                    <style name="gutterLeft" inherit="no" format="Length" type="Number"/>
                    <style name="gutterRight" inherit="no" format="Length" type="Number"/>
                    <style name="gutterTop" inherit="no" format="Length" type="Number"/>
                    <style name="horizontalAxisStyleName" inherit="no" type="String"/>
                    <style name="secondHorizontalAxisStyleName" inherit="no" type="String"/>
                    <style name="secondVerticalAxisStyleName" inherit="no" type="String"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="verticalAxisStyleName" inherit="no" type="String"/>
                </component>
                <component name="mx.charts.chartClasses.ChartBase" base="mx.core.UIComponent">
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style arrayType="String" name="chartSeriesStyles" inherit="no" type="Array"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="dataTipCalloutStroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="dataTipRenderer" inherit="no" type="Class"/>
                    <style name="fill" inherit="no" type="mx.graphics.IFill"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="maximumDataTipCount" inherit="no" type="int"/>
                    <style name="paddingBottom" inherit="no" format="Length" type="Number"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                    <style name="showDataTipTargets" inherit="no" type="Boolean"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                </component>
                <component name="mx.charts.chartClasses.DataTip" base="mx.core.UIComponent">
                    <style name="leading" inherit="no" format="Length" type="Number"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                    <style name="backgroundColor" inherit="no" format="Color" type="uint"/>
                    <style name="borderColor" inherit="no" format="Color" type="uint"/>
                    <style name="borderStyle" inherit="no" enumeration="inset,outset,solid,none" type="String"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="paddingBottom" inherit="no" format="Length" type="Number"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                    <style name="shadowColor" inherit="yes" format="Color" type="uint"/>
                </component>
                <component name="mx.charts.chartClasses.HLOCSeriesBase" base="mx.charts.chartClasses.Series">
                    <style name="itemRenderer" inherit="no" type="mx.core.IFactory"/>
                    <style name="legendMarkerRenderer" inherit="no" type="mx.core.IFactory"/>
                </component>
                <component name="mx.charts.ColumnChart" base="mx.charts.chartClasses.CartesianChart">
                    <style name="columnWidthRatio" inherit="no" type="Number"/>
                    <style name="maxColumnWidth" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.charts.GridLines" base="mx.charts.chartClasses.ChartElement">
                    <style name="direction" inherit="no" enumeration="horizontal,vertical,both" type="String"/>
                    <style name="horizontalAlternateFill" inherit="no" type="mx.graphics.IFill"/>
                    <style name="horizontalChangeCount" inherit="no" type="int"/>
                    <style name="horizontalFill" inherit="no" type="mx.graphics.IFill"/>
                    <style name="horizontalOriginStroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="horizontalShowOrigin" inherit="no" type="Boolean"/>
                    <style name="horizontalStroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="horizontalTickAligned" inherit="no" type="Boolean"/>
                    <style name="verticalAlternateFill" inherit="no" type="mx.graphics.IFill"/>
                    <style name="verticalChangeCount" inherit="no" type="int"/>
                    <style name="verticalFill" inherit="no" type="mx.graphics.IFill"/>
                    <style name="verticalOriginStroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="verticalShowOrigin" inherit="no" type="Boolean"/>
                    <style name="verticalStroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="verticalTickAligned" inherit="no" type="Boolean"/>
                </component>
                <component name="mx.charts.HLOCChart" base="mx.charts.chartClasses.CartesianChart">
                    <style name="columnWidthRatio" inherit="no" type="Number"/>
                    <style name="maxColumnWidth" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.charts.Legend" base="mx.containers.Tile">
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="backgroundColor" inherit="no" format="Color" type="uint"/>
                    <style name="borderStyle" inherit="no" enumeration="inset,outset,solid,none" type="String"/>
                    <style name="labelPlacement" inherit="yes" enumeration="top,bottom,right,left" type="String"/>
                    <style name="markerHeight" inherit="yes" format="Length" type="Number"/>
                    <style name="markerWidth" inherit="yes" format="Length" type="Number"/>
                    <style name="stroke" inherit="no" type="Object"/>
                </component>
                <component name="mx.charts.LegendItem" base="mx.core.UIComponent">
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="fill" inherit="no" type="Object"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="labelPlacement" inherit="yes" enumeration="top,bottom,right,left" type="String"/>
                    <style name="markerHeight" inherit="yes" format="Length" type="Number"/>
                    <style name="markerWidth" inherit="yes" format="Length" type="Number"/>
                    <style name="legendMarkerRenderer" inherit="no" type="mx.core.IFactory"/>
                    <style name="stroke" inherit="no" type="Object"/>
                </component>
                <component name="mx.charts.PieChart" base="mx.charts.chartClasses.PolarChart">
                    <style name="innerRadius" inherit="no" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                </component>
                <component name="mx.charts.series.AreaSeries" base="mx.charts.chartClasses.Series">
                    <style name="fill" inherit="no" type="mx.graphics.IFill"/>
                    <style name="stroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="itemRenderer" inherit="no" type="mx.core.IFactory"/>
                    <style name="legendMarkerRenderer" inherit="no" type="mx.core.IFactory"/>
                    <style name="areaFill" inherit="no" type="mx.graphics.IFill"/>
                    <style name="areaRenderer" inherit="no" type="mx.core.IFactory"/>
                    <style name="areaStroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="form" inherit="no" enumeration="segment,step,reverseStep,vertical,horizontal,curve" type="String"/>
                    <style name="radius" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.charts.series.BarSeries" base="mx.charts.chartClasses.Series">
                    <style name="fill" inherit="no" type="mx.graphics.IFill"/>
                    <style name="stroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="itemRenderer" inherit="no" type="mx.core.IFactory"/>
                    <style name="legendMarkerRenderer" inherit="no" type="mx.core.IFactory"/>
                </component>
                <component name="mx.charts.series.BubbleSeries" base="mx.charts.chartClasses.Series">
                    <style name="fill" inherit="no" type="mx.graphics.IFill"/>
                    <style name="stroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="itemRenderer" inherit="no" type="mx.core.IFactory"/>
                    <style name="legendMarkerRenderer" inherit="no" type="mx.core.IFactory"/>
                </component>
                <component name="mx.charts.series.CandlestickSeries" base="mx.charts.chartClasses.HLOCSeriesBase">
                    <style name="fill" inherit="no" type="mx.graphics.IFill"/>
                    <style name="stroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="declineFill" inherit="no" type="mx.graphics.IFill"/>
                    <style name="boxStroke" inherit="no" type="mx.graphics.IStroke"/>
                </component>
                <component name="mx.charts.series.ColumnSeries" base="mx.charts.chartClasses.Series">
                    <style name="fill" inherit="no" type="mx.graphics.IFill"/>
                    <style name="stroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="itemRenderer" inherit="no" type="mx.core.IFactory"/>
                    <style name="legendMarkerRenderer" inherit="no" type="mx.core.IFactory"/>
                </component>
                <component name="mx.charts.series.HLOCSeries" base="mx.charts.chartClasses.HLOCSeriesBase">
                    <style name="closeTickLength" inherit="no" format="Length" type="Number"/>
                    <style name="closeTickStroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="stroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="openTickLength" inherit="no" format="Length" type="Number"/>
                    <style name="openTickStroke" inherit="no" type="mx.graphics.IStroke"/>
                </component>
                <component name="mx.charts.series.LineSeries" base="mx.charts.chartClasses.Series">
                    <style name="fill" inherit="no" type="mx.graphics.IFill"/>
                    <style name="stroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="itemRenderer" inherit="no" type="mx.core.IFactory"/>
                    <style name="legendMarkerRenderer" inherit="no" type="mx.core.IFactory"/>
                    <style name="form" inherit="no" enumeration="segment,step,reverseStep,vertical,horizontal,curve" type="String"/>
                    <style name="lineSegmentRenderer" inherit="no" type="mx.core.IFactory"/>
                    <style name="lineStroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="radius" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.charts.series.PieSeries" base="mx.charts.chartClasses.Series">
                    <style name="itemRenderer" inherit="no" type="mx.core.IFactory"/>
                    <style name="legendMarkerRenderer" inherit="no" type="mx.core.IFactory"/>
                    <style name="calloutGap" inherit="no" format="Length" type="Number"/>
                    <style name="calloutStroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style arrayType="mx.graphics.IFill" name="fills" inherit="no" type="Array"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="innerRadius" inherit="no" type="Number"/>
                    <style name="insideLabelSizeLimit" inherit="no" type="Number"/>
                    <style name="labelPosition" inherit="no" enumeration="none,outside,callout,inside,insideWithCallout" type="String"/>
                    <style name="radialStroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="stroke" inherit="no" type="mx.graphics.IStroke"/>
                </component>
                <component name="mx.charts.series.PlotSeries" base="mx.charts.chartClasses.Series">
                    <style name="fill" inherit="no" type="mx.graphics.IFill"/>
                    <style name="stroke" inherit="no" type="mx.graphics.IStroke"/>
                    <style name="itemRenderer" inherit="no" type="mx.core.IFactory"/>
                    <style name="legendMarkerRenderer" inherit="no" type="mx.core.IFactory"/>
                    <style name="radius" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.containers.Accordion" base="mx.core.Container">
                    <style arrayType="Number" name="fillAlphas" inherit="no" type="Array"/>
                    <style arrayType="uint" name="fillColors" inherit="no" format="Color" type="Array"/>
                    <style arrayType="uint" name="selectedFillColors" inherit="no" format="Color" type="Array"/>
                    <style name="focusAlpha" inherit="no" type="Number"/>
                    <style name="focusRoundedCorners" inherit="no" type="String"/>
                    <style name="headerStyleName" inherit="no" type="String"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                    <style name="paddingBottom" inherit="no" format="Length" type="Number"/>
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                    <style name="headerHeight" inherit="no" format="Length" type="Number"/>
                    <style name="openDuration" inherit="no" format="Time" type="Number"/>
                    <style name="openEasingFunction" inherit="no" type="Function"/>
                    <style name="textRollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="textSelectedColor" inherit="yes" format="Color" type="uint"/>
                </component>
                <component name="mx.containers.ApplicationControlBar" base="mx.containers.ControlBar">
                    <style arrayType="Number" name="fillAlphas" inherit="no" type="Array"/>
                    <style arrayType="uint" name="fillColors" inherit="no" format="Color" type="Array"/>
                </component>
                <component name="mx.containers.Box" base="mx.core.Container">
                    <style name="horizontalAlign" inherit="no" enumeration="left,center,right" type="String"/>
                    <style name="verticalAlign" inherit="no" enumeration="bottom,middle,top" type="String"/>
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                    <style name="paddingBottom" inherit="no" format="Length" type="Number"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.containers.DividedBox" base="mx.containers.Box">
                    <style name="dividerAffordance" inherit="no" format="Length" type="Number"/>
                    <style name="dividerAlpha" inherit="no" type="Number"/>
                    <style name="dividerColor" inherit="yes" format="Color" type="uint"/>
                    <style name="dividerSkin" inherit="no" type="Class"/>
                    <style name="dividerThickness" inherit="no" format="Length" type="Number"/>
                    <style name="horizontalDividerCursor" inherit="no" type="Class"/>
                    <style name="verticalDividerCursor" inherit="no" type="Class"/>
                </component>
                <component name="mx.containers.dividedBoxClasses.BoxDivider" base="mx.core.UIComponent">
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                    <style name="dividerAffordance" inherit="no" format="Length" type="Number"/>
                    <style name="dividerAlpha" inherit="no" type="Number"/>
                    <style name="dividerColor" inherit="yes" format="Color" type="uint"/>
                    <style name="dividerThickness" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.containers.Form" base="mx.core.Container">
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                    <style name="indicatorGap" inherit="yes" format="Length" type="Number"/>
                    <style name="labelWidth" inherit="yes" format="Length" type="Number"/>
                    <style name="paddingBottom" inherit="no" format="Length" type="Number"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.containers.FormHeading" base="mx.core.UIComponent">
                    <style name="leading" inherit="no" format="Length" type="Number"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                    <style name="indicatorGap" inherit="yes" format="Length" type="Number"/>
                    <style name="labelWidth" inherit="yes" format="Length" type="Number"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.containers.FormItem" base="mx.core.Container">
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                    <style name="horizontalAlign" inherit="no" enumeration="left,center,right" type="String"/>
                    <style name="indicatorGap" inherit="yes" format="Length" type="Number"/>
                    <style name="indicatorSkin" inherit="no" type="Class"/>
                    <style name="labelWidth" inherit="yes" format="Length" type="Number"/>
                    <style name="paddingBottom" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.containers.Grid" base="mx.containers.Box">
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.containers.GridRow" base="mx.containers.HBox">
                    <style name="horizontalAlign" inherit="no" enumeration="left,center,right" type="String"/>
                    <style name="verticalAlign" inherit="no" enumeration="bottom,middle,top" type="String"/>
                </component>
                <component name="mx.containers.Panel" base="mx.core.Container">
                    <style name="horizontalAlign" inherit="no" enumeration="left,center,right" type="String"/>
                    <style name="verticalAlign" inherit="no" enumeration="bottom,middle,top" type="String"/>
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                    <style name="modalTransparency" inherit="yes" type="Number"/>
                    <style name="modalTransparencyBlur" inherit="yes" type="Number"/>
                    <style name="modalTransparencyColor" inherit="yes" format="Color" type="uint"/>
                    <style name="modalTransparencyDuration" inherit="yes" format="Time" type="Number"/>
                    <style name="borderAlpha" inherit="no" type="Number"/>
                    <style name="borderThicknessBottom" inherit="no" format="Length" type="Number"/>
                    <style name="borderThicknessLeft" inherit="no" format="Length" type="Number"/>
                    <style name="borderThicknessRight" inherit="no" format="Length" type="Number"/>
                    <style name="borderThicknessTop" inherit="no" format="Length" type="Number"/>
                    <style name="controlBarStyleName" inherit="no" type="String"/>
                    <style name="cornerRadius" inherit="no" format="Length" type="Number"/>
                    <style name="dropShadowEnabled" inherit="no" type="Boolean"/>
                    <style arrayType="uint" name="footerColors" inherit="yes" format="Color" type="Array"/>
                    <style arrayType="uint" name="headerColors" inherit="yes" format="Color" type="Array"/>
                    <style name="headerHeight" inherit="no" format="Length" type="Number"/>
                    <style arrayType="Number" name="highlightAlphas" inherit="no" type="Array"/>
                    <style name="paddingBottom" inherit="no" format="Length" type="Number"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                    <style name="roundedBottomCorners" inherit="no" type="Boolean"/>
                    <style name="shadowDirection" inherit="no" enumeration="left,center,right" type="String"/>
                    <style name="shadowDistance" inherit="no" format="Length" type="Number"/>
                    <style name="statusStyleName" inherit="no" type="String"/>
                    <style name="titleBackgroundSkin" inherit="no" type="Class"/>
                    <style name="titleStyleName" inherit="no" type="String"/>
                </component>
                <component name="mx.containers.TabNavigator" base="mx.containers.ViewStack">
                    <style arrayType="Number" name="fillAlphas" inherit="no" type="Array"/>
                    <style arrayType="uint" name="fillColors" inherit="no" format="Color" type="Array"/>
                    <style name="focusAlpha" inherit="no" type="Number"/>
                    <style name="focusRoundedCorners" inherit="no" type="String"/>
                    <style name="firstTabStyleName" inherit="no" type="String"/>
                    <style name="horizontalAlign" inherit="no" enumeration="left,center,right" type="String"/>
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="lastTabStyleName" inherit="no" type="String"/>
                    <style name="selectedTabTextStyleName" inherit="no" type="String"/>
                    <style name="tabHeight" inherit="no" format="Length" type="Number"/>
                    <style name="tabStyleName" inherit="no" type="String"/>
                    <style name="tabWidth" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.containers.Tile" base="mx.core.Container">
                    <style name="horizontalAlign" inherit="no" enumeration="left,center,right" type="String"/>
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="paddingBottom" inherit="no" format="Length" type="Number"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                    <style name="verticalAlign" inherit="no" enumeration="bottom,middle,top" type="String"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.containers.TitleWindow" base="mx.containers.Panel">
                    <style name="closeButtonDisabledSkin" inherit="no" type="Class"/>
                    <style name="closeButtonDownSkin" inherit="no" type="Class"/>
                    <style name="closeButtonOverSkin" inherit="no" type="Class"/>
                    <style name="closeButtonUpSkin" inherit="no" type="Class"/>
                </component>
                <component name="mx.containers.ViewStack" base="mx.core.Container">
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                    <style name="paddingBottom" inherit="no" format="Length" type="Number"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.controls.Alert" base="mx.containers.Panel">
                    <style name="buttonStyleName" inherit="no" type="String"/>
                    <style name="messageStyleName" inherit="no" type="String"/>
                    <style name="titleStyleName" inherit="no" type="String"/>
                </component>
                <component name="mx.controls.alertClasses.AlertForm" base="mx.core.UIComponent">
                    <style name="leading" inherit="no" format="Length" type="Number"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                </component>
                <component name="mx.controls.Button" base="mx.core.UIComponent">
                    <style name="focusAlpha" inherit="no" type="Number"/>
                    <style name="focusRoundedCorners" inherit="no" type="String"/>
                    <style name="leading" inherit="no" format="Length" type="Number"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="borderColor" inherit="no" format="Color" type="uint"/>
                    <style name="cornerRadius" inherit="no" format="Length" type="Number"/>
                    <style arrayType="Number" name="fillAlphas" inherit="no" type="Array"/>
                    <style arrayType="uint" name="fillColors" inherit="no" format="Color" type="Array"/>
                    <style arrayType="Number" name="highlightAlphas" inherit="no" type="Array"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="paddingBottom" inherit="no" format="Length" type="Number"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                    <style name="repeatDelay" inherit="no" format="Time" type="Number"/>
                    <style name="repeatInterval" inherit="no" format="Time" type="Number"/>
                    <style name="textRollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="textSelectedColor" inherit="yes" format="Color" type="uint"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                    <style name="upSkin" inherit="no" type="Class"/>
                    <style name="overSkin" inherit="no" type="Class"/>
                    <style name="downSkin" inherit="no" type="Class"/>
                    <style name="disabledSkin" inherit="no" type="Class"/>
                    <style name="selectedUpSkin" inherit="no" type="Class"/>
                    <style name="selectedOverSkin" inherit="no" type="Class"/>
                    <style name="selectedDownSkin" inherit="no" type="Class"/>
                    <style name="selectedDisabledSkin" inherit="no" type="Class"/>
                    <style name="icon" inherit="no" type="Class"/>
                    <style name="upIcon" inherit="no" type="Class"/>
                    <style name="overIcon" inherit="no" type="Class"/>
                    <style name="downIcon" inherit="no" type="Class"/>
                    <style name="disabledIcon" inherit="no" type="Class"/>
                    <style name="selectedUpIcon" inherit="no" type="Class"/>
                    <style name="selectedOverIcon" inherit="no" type="Class"/>
                    <style name="selectedDownIcon" inherit="no" type="Class"/>
                    <style name="selectedDisabledIcon" inherit="no" type="Class"/>
                </component>
                <component name="mx.controls.ButtonBar" base="mx.controls.NavBar">
                    <style name="focusAlpha" inherit="no" type="Number"/>
                    <style name="focusRoundedCorners" inherit="no" type="String"/>
                    <style name="buttonHeight" inherit="no" format="Length" type="Number"/>
                    <style name="buttonStyleName" inherit="no" type="String"/>
                    <style name="buttonWidth" inherit="no" format="Length" type="Number"/>
                    <style name="firstButtonStyleName" inherit="no" type="String"/>
                    <style name="horizontalAlign" inherit="no" enumeration="left,center,right" type="String"/>
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="lastButtonStyleName" inherit="no" type="String"/>
                    <style name="verticalAlign" inherit="no" enumeration="top,middle,bottom" type="String"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.controls.CalendarLayout" base="mx.core.UIComponent">
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                    <style name="leading" inherit="no" format="Length" type="Number"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                    <style name="rollOverIndicatorSkin" inherit="no" type="Class"/>
                    <style name="selectionIndicatorSkin" inherit="no" type="Class"/>
                    <style name="todayIndicatorSkin" inherit="no" type="Class"/>
                    <style name="todayStyleName" inherit="no" type="String"/>
                    <style name="weekDayStyleName" inherit="no" type="String"/>
                </component>
                <component name="mx.controls.ColorPicker" base="mx.controls.ComboBase">
                    <style name="focusAlpha" inherit="no" type="Number"/>
                    <style name="focusRoundedCorners" inherit="no" type="String"/>
                    <style name="leading" inherit="no" format="Length" type="Number"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                    <style name="backgroundColor" inherit="no" format="Color" type="uint"/>
                    <style name="borderColor" inherit="no" format="Color" type="uint"/>
                    <style name="closeDuration" inherit="no" format="Time" type="Number"/>
                    <style name="closeEasingFunction" inherit="no" type="Function"/>
                    <style name="columnCount" inherit="no" type="int"/>
                    <style arrayType="Number" name="fillAlphas" inherit="no" type="Array"/>
                    <style arrayType="uint" name="fillColors" inherit="no" format="Color" type="Array"/>
                    <style arrayType="Number" name="highlightAlphas" inherit="no" type="Array"/>
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="openDuration" inherit="no" format="Time" type="Number"/>
                    <style name="openEasingFunction" inherit="no" type="Function"/>
                    <style name="paddingBottom" inherit="no" format="Length" type="Number"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                    <style name="previewHeight" inherit="no" format="Length" type="Number"/>
                    <style name="previewWidth" inherit="no" format="Length" type="Number"/>
                    <style name="swatchBorderColor" inherit="no" format="Color" type="uint"/>
                    <style name="swatchBorderSize" inherit="no" format="Length" type="Number"/>
                    <style name="swatchGridBackgroundColor" inherit="no" format="Color" type="uint"/>
                    <style name="swatchGridBorderSize" inherit="no" format="Length" type="Number"/>
                    <style name="swatchHeight" inherit="no" format="Length" type="Number"/>
                    <style name="swatchHighlightColor" inherit="no" format="Color" type="uint"/>
                    <style name="swatchHighlightSize" inherit="no" format="Length" type="Number"/>
                    <style name="swatchPanelStyleName" inherit="no" type="String"/>
                    <style name="swatchWidth" inherit="no" format="Length" type="Number"/>
                    <style name="textFieldWidth" inherit="no" format="Length" type="Number"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.controls.colorPickerClasses.SwatchPanel" base="mx.core.UIComponent">
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="backgroundColor" inherit="no" format="Color" type="uint"/>
                    <style name="borderColor" inherit="no" format="Color" type="uint"/>
                    <style name="columnCount" inherit="no" type="int"/>
                    <style name="highlightColor" inherit="yes" format="Color" type="uint"/>
                    <style name="shadowCapColor" inherit="yes" format="Color" type="uint"/>
                    <style name="shadowColor" inherit="yes" format="Color" type="uint"/>
                    <style name="previewHeight" inherit="no" format="Length" type="Number"/>
                    <style name="previewWidth" inherit="no" format="Length" type="Number"/>
                    <style name="swatchBorderSize" inherit="no" format="Length" type="Number"/>
                    <style name="swatchBorderColor" inherit="no" format="Color" type="uint"/>
                    <style name="swatchGridBorderSize" inherit="no" format="Length" type="Number"/>
                    <style name="swatchGridBackgroundColor" inherit="no" format="Color" type="uint"/>
                    <style name="swatchHeight" inherit="no" format="Length" type="Number"/>
                    <style name="swatchHighlightColor" inherit="no" format="Color" type="uint"/>
                    <style name="swatchHighlightSize" inherit="no" format="Length" type="Number"/>
                    <style name="swatchWidth" inherit="no" format="Length" type="Number"/>
                    <style name="textFieldWidth" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.controls.ComboBase" base="mx.core.UIComponent">
                    <style name="upSkin" inherit="no" type="Class"/>
                    <style name="overSkin" inherit="no" type="Class"/>
                    <style name="downSkin" inherit="no" type="Class"/>
                    <style name="disabledSkin" inherit="no" type="Class"/>
                    <style name="editableUpSkin" inherit="no" type="Class"/>
                    <style name="editableOverSkin" inherit="no" type="Class"/>
                    <style name="editableDownSkin" inherit="no" type="Class"/>
                    <style name="editableDisabledSkin" inherit="no" type="Class"/>
                </component>
                <component name="mx.controls.ComboBox" base="mx.controls.ComboBase">
                    <style name="focusAlpha" inherit="no" type="Number"/>
                    <style name="focusRoundedCorners" inherit="no" type="String"/>
                    <style name="leading" inherit="no" format="Length" type="Number"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="borderColor" inherit="no" format="Color" type="uint"/>
                    <style name="cornerRadius" inherit="no" format="Length" type="Number"/>
                    <style arrayType="Number" name="fillAlphas" inherit="no" type="Array"/>
                    <style arrayType="uint" name="fillColors" inherit="no" format="Color" type="Array"/>
                    <style arrayType="Number" name="highlightAlphas" inherit="no" type="Array"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                    <style arrayType="uint" name="alternatingItemColors" inherit="yes" format="Color" type="Array"/>
                    <style name="arrowButtonWidth" inherit="no" format="Length" type="Number"/>
                    <style name="borderThickness" inherit="no" format="Length" type="Number"/>
                    <style name="closeDuration" inherit="no" format="Time" type="Number"/>
                    <style name="closeEasingFunction" inherit="no" type="Function"/>
                    <style name="dropdownBorderColor" inherit="yes" format="Color" type="uint"/>
                    <style name="dropDownStyleName" inherit="no" type="String"/>
                    <style name="openDuration" inherit="no" format="Time" type="Number"/>
                    <style name="openEasingFunction" inherit="no" type="Function"/>
                    <style name="rollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="selectionColor" inherit="yes" format="Color" type="uint"/>
                    <style name="selectionDuration" inherit="no" format="Time" type="uint"/>
                    <style name="selectionEasingFunction" inherit="no" type="Function"/>
                    <style name="textRollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="textSelectedColor" inherit="yes" format="Color" type="uint"/>
                </component>
                <component name="mx.controls.DataGrid" base="mx.controls.dataGridClasses.DataGridBase">
                    <style name="verticalGridLines" inherit="no" type="Boolean"/>
                    <style name="horizontalGridLines" inherit="no" type="Boolean"/>
                    <style name="verticalGridLineColor" inherit="yes" format="Color" type="uint"/>
                    <style name="horizontalGridLineColor" inherit="yes" format="Color" type="uint"/>
                    <style arrayType="uint" name="headerColors" inherit="yes" format="Color" type="Array"/>
                    <style name="rollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="selectionColor" inherit="yes" format="Color" type="uint"/>
                    <style name="headerStyleName" inherit="no" type="String"/>
                    <style name="columnResizeSkin" inherit="no" type="Class"/>
                    <style name="headerSeparatorSkin" inherit="no" type="Class"/>
                    <style name="sortArrowSkin" inherit="no" type="Class"/>
                    <style name="stretchCursor" inherit="no" type="Class"/>
                    <style name="columnDropIndicatorSkin" inherit="no" type="Class"/>
                    <style name="headerDragProxyStyleName" inherit="no" type="String"/>
                </component>
                <component name="mx.controls.dataGridClasses.DataGridColumn" base="mx.styles.CSSStyleDeclaration">
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                    <style name="backgroundColor" inherit="no" format="Color" type="uint"/>
                    <style name="headerStyleName" inherit="no" type="String"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.controls.DateChooser" base="mx.core.UIComponent">
                    <style name="focusAlpha" inherit="no" type="Number"/>
                    <style name="focusRoundedCorners" inherit="no" type="String"/>
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                    <style name="leading" inherit="no" format="Length" type="Number"/>
                    <style name="borderColor" inherit="no" format="Color" type="uint"/>
                    <style name="cornerRadius" inherit="no" format="Length" type="Number"/>
                    <style arrayType="Number" name="fillAlphas" inherit="no" type="Array"/>
                    <style arrayType="uint" name="fillColors" inherit="no" format="Color" type="Array"/>
                    <style arrayType="Number" name="highlightAlphas" inherit="no" type="Array"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                    <style name="backgroundAlpha" inherit="no" type="Number"/>
                    <style name="backgroundColor" inherit="no" format="Color" type="uint"/>
                    <style name="borderThickness" inherit="no" format="Length" type="Number"/>
                    <style arrayType="uint" name="headerColors" inherit="yes" format="Color" type="Array"/>
                    <style name="headerStyleName" inherit="no" type="String"/>
                    <style name="nextMonthDisabledSkin" inherit="no" type="Class"/>
                    <style name="nextMonthDownSkin" inherit="no" type="Class"/>
                    <style name="nextMonthOverSkin" inherit="no" type="Class"/>
                    <style name="nextMonthUpSkin" inherit="no" type="Class"/>
                    <style name="nextYearDisabledSkin" inherit="no" type="Class"/>
                    <style name="nextYearDownSkin" inherit="no" type="Class"/>
                    <style name="nextYearOverSkin" inherit="no" type="Class"/>
                    <style name="nextYearUpSkin" inherit="no" type="Class"/>
                    <style name="prevMonthDisabledSkin" inherit="no" type="Class"/>
                    <style name="prevMonthDownSkin" inherit="no" type="Class"/>
                    <style name="prevMonthOverSkin" inherit="no" type="Class"/>
                    <style name="prevMonthUpSkin" inherit="no" type="Class"/>
                    <style name="prevYearDisabledSkin" inherit="no" type="Class"/>
                    <style name="prevYearDownSkin" inherit="no" type="Class"/>
                    <style name="prevYearOverSkin" inherit="no" type="Class"/>
                    <style name="prevYearUpSkin" inherit="no" type="Class"/>
                    <style name="rollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="rollOverIndicatorSkin" inherit="no" type="Class"/>
                    <style name="selectionColor" inherit="yes" format="Color" type="uint"/>
                    <style name="selectionIndicatorSkin" inherit="no" type="Class"/>
                    <style name="todayColor" inherit="yes" format="Color" type="uint"/>
                    <style name="todayIndicatorSkin" inherit="no" type="Class"/>
                    <style name="todayStyleName" inherit="no" type="String"/>
                    <style name="weekDayStyleName" inherit="no" type="String"/>
                </component>
                <component name="mx.controls.DateField" base="mx.controls.ComboBase">
                    <style name="focusAlpha" inherit="no" type="Number"/>
                    <style name="focusRoundedCorners" inherit="no" type="String"/>
                    <style name="leading" inherit="no" format="Length" type="Number"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="borderColor" inherit="no" format="Color" type="uint"/>
                    <style name="cornerRadius" inherit="no" format="Length" type="Number"/>
                    <style arrayType="Number" name="fillAlphas" inherit="no" type="Array"/>
                    <style arrayType="uint" name="fillColors" inherit="no" format="Color" type="Array"/>
                    <style arrayType="Number" name="highlightAlphas" inherit="no" type="Array"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                    <style name="borderThickness" inherit="no" format="Length" type="Number"/>
                    <style name="dateChooserStyleName" inherit="no" type="String"/>
                    <style arrayType="uint" name="headerColors" inherit="yes" format="Color" type="Array"/>
                    <style name="headerStyleName" inherit="no" type="String"/>
                    <style name="rollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="selectionColor" inherit="yes" format="Color" type="uint"/>
                    <style name="todayColor" inherit="yes" format="Color" type="uint"/>
                    <style name="todayStyleName" inherit="no" type="String"/>
                    <style name="weekDayStyleName" inherit="no" type="String"/>
                </component>
                <component name="mx.controls.HRule" base="mx.core.UIComponent">
                    <style name="shadowColor" inherit="yes" format="Color" type="uint"/>
                    <style name="strokeColor" inherit="yes" format="Color" type="uint"/>
                    <style name="strokeWidth" inherit="yes" format="Length" type="Number"/>
                </component>
                <component name="mx.controls.HScrollBar" base="mx.controls.scrollClasses.ScrollBar">
                    <style name="repeatDelay" inherit="no" format="Time" type="Number"/>
                    <style name="repeatInterval" inherit="no" format="Time" type="Number"/>
                </component>
                <component name="mx.controls.HSlider" base="mx.controls.sliderClasses.Slider">
                    <style name="dataTipPlacement" inherit="no" type="String"/>
                </component>
                <component name="mx.controls.Label" base="mx.core.UIComponent">
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="paddingBottom" inherit="no" format="Length" type="Number"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.controls.LinkBar" base="mx.controls.NavBar">
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="paddingBottom" inherit="no" format="Length" type="Number"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                    <style name="rollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="selectionColor" inherit="yes" format="Color" type="uint"/>
                    <style name="separatorColor" inherit="yes" format="Color" type="uint"/>
                    <style name="separatorSkin" inherit="no" type="Class"/>
                    <style name="separatorWidth" inherit="yes" format="Length" type="Number"/>
                    <style name="textRollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="textSelectedColor" inherit="yes" format="Color" type="uint"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.controls.LinkButton" base="mx.controls.Button">
                    <style name="cornerRadius" inherit="no" format="Length" type="Number"/>
                    <style name="rollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="selectionColor" inherit="yes" format="Color" type="uint"/>
                    <style name="textRollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="textSelectedColor" inherit="yes" format="Color" type="uint"/>
                </component>
                <component name="mx.controls.listClasses.ListBase" base="mx.core.ScrollControlBase">
                    <style name="focusAlpha" inherit="no" type="Number"/>
                    <style name="focusRoundedCorners" inherit="no" type="String"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style arrayType="uint" name="alternatingItemColors" inherit="yes" format="Color" type="Array"/>
                    <style name="dropIndicatorSkin" inherit="no" type="Class"/>
                    <style name="paddingBottom" inherit="no" format="Length" type="Number"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                    <style name="rollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="selectionColor" inherit="yes" format="Color" type="uint"/>
                    <style name="selectionDisabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="selectionDuration" inherit="no" format="Time" type="Number"/>
                    <style name="selectionEasingFunction" inherit="no" type="Function"/>
                    <style name="textRollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="textSelectedColor" inherit="yes" format="Color" type="uint"/>
                    <style name="useRollOver" inherit="no" type="Boolean"/>
                    <style name="verticalAlign" inherit="no" enumeration="bottom,middle,top" type="String"/>
                </component>
                <component name="mx.controls.listClasses.ListBaseContentHolder" base="mx.core.UIComponent">
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="backgroundColor" inherit="no" format="Color" type="uint"/>
                </component>
                <component name="mx.controls.listClasses.ListItemRenderer" base="mx.core.UIComponent">
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                </component>
                <component name="mx.controls.listClasses.TileListItemRenderer" base="mx.core.UIComponent">
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.controls.Menu" base="mx.controls.List">
                    <style arrayType="uint" name="alternatingItemColors" inherit="yes" format="Color" type="Array"/>
                    <style name="openDuration" inherit="no" format="Time" type="Number"/>
                    <style name="rollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="selectionColor" inherit="yes" format="Color" type="uint"/>
                    <style name="selectionEasingFunction" inherit="no" type="Function"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                    <style name="textRollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="textSelectedColor" inherit="yes" format="Color" type="uint"/>
                    <style name="branchIcon" inherit="no" type="Class"/>
                    <style name="branchDisabledIcon" inherit="no" type="Class"/>
                    <style name="checkIcon" inherit="no" type="Class"/>
                    <style name="checkDisabledIcon" inherit="no" type="Class"/>
                    <style name="radioIcon" inherit="no" type="Class"/>
                    <style name="radioDisabledIcon" inherit="no" type="Class"/>
                    <style name="separatorSkin" inherit="no" type="Class"/>
                </component>
                <component name="mx.controls.MenuBar" base="mx.core.UIComponent">
                    <style name="focusAlpha" inherit="no" type="Number"/>
                    <style name="focusRoundedCorners" inherit="no" type="String"/>
                    <style name="leading" inherit="no" format="Length" type="Number"/>
                    <style name="borderColor" inherit="no" format="Color" type="uint"/>
                    <style name="cornerRadius" inherit="no" format="Length" type="Number"/>
                    <style arrayType="Number" name="fillAlphas" inherit="no" type="Array"/>
                    <style arrayType="uint" name="fillColors" inherit="no" format="Color" type="Array"/>
                    <style arrayType="Number" name="highlightAlphas" inherit="no" type="Array"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                    <style name="backgroundColor" inherit="no" format="Color" type="uint"/>
                    <style name="backgroundAlpha" inherit="no" type="Number"/>
                    <style name="backgroundSkin" inherit="no" type="Class"/>
                    <style name="itemUpSkin" inherit="no" type="Class"/>
                    <style name="itemOverSkin" inherit="no" type="Class"/>
                    <style name="itemDownSkin" inherit="no" type="Class"/>
                    <style name="menuStyleName" inherit="no" type="String"/>
                    <style name="rollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="selectionColor" inherit="yes" format="Color" type="uint"/>
                </component>
                <component name="mx.controls.menuClasses.MenuBarItem" base="mx.core.UIComponent">
                    <style name="leading" inherit="no" format="Length" type="Number"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                </component>
                <component name="mx.controls.menuClasses.MenuItemRenderer" base="mx.core.UIComponent">
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                </component>
                <component name="mx.controls.NumericStepper" base="mx.core.UIComponent">
                    <style name="backgroundAlpha" inherit="no" type="Number"/>
                    <style name="backgroundColor" inherit="no" format="Color" type="uint"/>
                    <style name="backgroundDisabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="backgroundImage" inherit="no" format="File" type="Object"/>
                    <style name="backgroundSize" inherit="no" type="String"/>
                    <style name="borderColor" inherit="no" format="Color" type="uint"/>
                    <style name="borderSides" inherit="no" type="String"/>
                    <style name="borderSkin" inherit="no" type="Class"/>
                    <style name="borderStyle" inherit="no" enumeration="inset,outset,solid,none" type="String"/>
                    <style name="borderThickness" inherit="no" format="Length" type="Number"/>
                    <style name="cornerRadius" inherit="no" format="Length" type="Number"/>
                    <style name="dropShadowEnabled" inherit="no" type="Boolean"/>
                    <style name="dropShadowColor" inherit="yes" format="Color" type="uint"/>
                    <style name="shadowDirection" inherit="no" enumeration="left,center,right" type="String"/>
                    <style name="shadowDistance" inherit="no" format="Length" type="Number"/>
                    <style name="focusAlpha" inherit="no" type="Number"/>
                    <style name="focusRoundedCorners" inherit="no" type="String"/>
                    <style name="leading" inherit="no" format="Length" type="Number"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                    <style name="downArrowDisabledSkin" inherit="no" type="Class"/>
                    <style name="downArrowDownSkin" inherit="no" type="Class"/>
                    <style name="downArrowOverSkin" inherit="no" type="Class"/>
                    <style name="downArrowUpSkin" inherit="no" type="Class"/>
                    <style arrayType="Number" name="highlightAlphas" inherit="no" type="Array"/>
                    <style name="upArrowDisabledSkin" inherit="no" type="Class"/>
                    <style name="upArrowDownSkin" inherit="no" type="Class"/>
                    <style name="upArrowOverSkin" inherit="no" type="Class"/>
                    <style name="upArrowUpSkin" inherit="no" type="Class"/>
                </component>
                <component name="mx.controls.PopUpButton" base="mx.controls.Button">
                    <style name="arrowButtonWidth" inherit="no" format="Length" type="Number"/>
                    <style name="closeDuration" inherit="no" format="Time" type="Number"/>
                    <style name="closeEasingFunction" inherit="no" type="Function"/>
                    <style name="openDuration" inherit="no" format="Time" type="Number"/>
                    <style name="openEasingFunction" inherit="no" type="Function"/>
                    <style name="popUpDownSkin" inherit="no" type="Class"/>
                    <style name="popUpGap" inherit="no" format="Length" type="Number"/>
                    <style name="popUpIcon" inherit="no" type="Class"/>
                    <style name="popUpOverSkin" inherit="no" type="Class"/>
                </component>
                <component name="mx.controls.ProgressBar" base="mx.core.UIComponent">
                    <style name="barColor" inherit="yes" format="Color" type="uint"/>
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                    <style name="leading" inherit="no" format="Length" type="Number"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                    <style name="barSkin" inherit="no" type="Class"/>
                    <style name="borderColor" inherit="no" format="Color" type="uint"/>
                    <style name="indeterminateSkin" inherit="no" type="Class"/>
                    <style name="trackSkin" inherit="no" type="Class"/>
                    <style name="themeColor" inherit="yes" format="Color" type="uint"/>
                    <style arrayType="uint" name="trackColors" inherit="no" format="Color" type="Array"/>
                    <style name="trackHeight" inherit="no" format="Length" type="Number"/>
                    <style name="labelWidth" inherit="yes" format="Length" type="Number"/>
                </component>
                <component name="mx.controls.scrollClasses.ScrollBar" base="mx.core.UIComponent">
                    <style name="borderColor" inherit="no" format="Color" type="uint"/>
                    <style name="cornerRadius" inherit="no" format="Length" type="Number"/>
                    <style arrayType="Number" name="fillAlphas" inherit="no" type="Array"/>
                    <style arrayType="uint" name="fillColors" inherit="no" format="Color" type="Array"/>
                    <style arrayType="Number" name="highlightAlphas" inherit="no" type="Array"/>
                    <style name="downArrowDisabledSkin" inherit="no" type="Class"/>
                    <style name="downArrowDownSkin" inherit="no" type="Class"/>
                    <style name="downArrowOverSkin" inherit="no" type="Class"/>
                    <style name="downArrowUpSkin" inherit="no" type="Class"/>
                    <style name="thumbDownSkin" inherit="no" type="Class"/>
                    <style name="thumbIcon" inherit="no" type="Class"/>
                    <style name="thumbOverSkin" inherit="no" type="Class"/>
                    <style name="thumbUpSkin" inherit="no" type="Class"/>
                    <style arrayType="uint" name="trackColors" inherit="no" format="Color" type="Array"/>
                    <style name="trackSkin" inherit="no" type="Class"/>
                    <style name="upArrowDisabledSkin" inherit="no" type="Class"/>
                    <style name="upArrowDownSkin" inherit="no" type="Class"/>
                    <style name="upArrowOverSkin" inherit="no" type="Class"/>
                    <style name="upArrowUpSkin" inherit="no" type="Class"/>
                </component>
                <component name="mx.controls.sliderClasses.Slider" base="mx.core.UIComponent">
                    <style arrayType="Number" name="fillAlphas" inherit="no" type="Array"/>
                    <style arrayType="uint" name="fillColors" inherit="no" format="Color" type="Array"/>
                    <style name="borderColor" inherit="no" format="Color" type="uint"/>
                    <style arrayType="uint" name="fillColors" inherit="no" format="Color" type="Array"/>
                    <style name="invertThumbDirection" inherit="no" type="Boolean"/>
                    <style name="labelOffset" inherit="no" format="Length" type="Number"/>
                    <style name="labelStyleName" inherit="no" type="String"/>
                    <style name="slideDuration" inherit="no" format="Time" type="Number"/>
                    <style name="slideEasingFunction" inherit="no" type="Function"/>
                    <style name="thumbOffset" inherit="no" format="Length" type="Number"/>
                    <style name="tickColor" inherit="no" format="Color" type="uint"/>
                    <style name="tickLength" inherit="no" format="Length" type="Number"/>
                    <style name="tickOffset" inherit="no" format="Length" type="Number"/>
                    <style name="tickThickness" inherit="no" format="Length" type="Number"/>
                    <style arrayType="uint" name="trackColors" inherit="no" format="Color" type="Array"/>
                    <style name="showTrackHighlight" inherit="no" type="Boolean"/>
                    <style name="trackMargin" inherit="no" format="Length" type="Number"/>
                    <style name="dataTipStyleName" inherit="no" type="String"/>
                    <style name="dataTipOffset" inherit="no" format="Length" type="Number"/>
                    <style name="dataTipPrecision" inherit="no" type="int"/>
                    <style name="thumbUpSkin" inherit="no" type="Class"/>
                    <style name="thumbOverSkin" inherit="no" type="Class"/>
                    <style name="thumbDownSkin" inherit="no" type="Class"/>
                    <style name="thumbDisabledSkin" inherit="no" type="Class"/>
                    <style name="trackHighlightSkin" inherit="no" type="Class"/>
                    <style name="trackSkin" inherit="no" type="Class"/>
                </component>
                <component name="mx.controls.SWFLoader" base="mx.core.UIComponent">
                    <style name="brokenImageBorderSkin" inherit="no" type="Class"/>
                    <style name="brokenImageSkin" inherit="no" type="Class"/>
                    <style name="horizontalAlign" inherit="no" enumeration="left,center,right" type="String"/>
                    <style name="verticalAlign" inherit="no" enumeration="bottom,middle,top" type="String"/>
                </component>
                <component name="mx.controls.TabBar" base="mx.controls.ToggleButtonBar">
                    <style name="firstTabStyleName" inherit="no" type="String"/>
                    <style name="horizontalAlign" inherit="no" enumeration="left,center,right" type="String"/>
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="lastTabStyleName" inherit="no" type="String"/>
                    <style name="selectedTabTextStyleName" inherit="no" type="String"/>
                    <style name="tabStyleName" inherit="no" type="String"/>
                    <style name="tabHeight" inherit="no" format="Length" type="Number"/>
                    <style name="tabWidth" inherit="no" format="Length" type="Number"/>
                    <style name="verticalAlign" inherit="no" enumeration="top,middle,bottom" type="String"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.controls.Text" base="mx.controls.Label">
                    <style name="leading" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.controls.TextArea" base="mx.core.ScrollControlBase">
                    <style name="focusAlpha" inherit="no" type="Number"/>
                    <style name="focusRoundedCorners" inherit="no" type="String"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                </component>
                <component name="mx.controls.TextInput" base="mx.core.UIComponent">
                    <style name="backgroundAlpha" inherit="no" type="Number"/>
                    <style name="backgroundColor" inherit="no" format="Color" type="uint"/>
                    <style name="backgroundDisabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="backgroundImage" inherit="no" format="File" type="Object"/>
                    <style name="backgroundSize" inherit="no" type="String"/>
                    <style name="borderColor" inherit="no" format="Color" type="uint"/>
                    <style name="borderSides" inherit="no" type="String"/>
                    <style name="borderSkin" inherit="no" type="Class"/>
                    <style name="borderStyle" inherit="no" enumeration="inset,outset,solid,none" type="String"/>
                    <style name="borderThickness" inherit="no" format="Length" type="Number"/>
                    <style name="cornerRadius" inherit="no" format="Length" type="Number"/>
                    <style name="dropShadowEnabled" inherit="no" type="Boolean"/>
                    <style name="dropShadowColor" inherit="yes" format="Color" type="uint"/>
                    <style name="shadowDirection" inherit="no" enumeration="left,center,right" type="String"/>
                    <style name="shadowDistance" inherit="no" format="Length" type="Number"/>
                    <style name="focusAlpha" inherit="no" type="Number"/>
                    <style name="focusRoundedCorners" inherit="no" type="String"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                </component>
                <component name="mx.controls.ToggleButtonBar" base="mx.controls.ButtonBar">
                    <style name="selectedButtonTextStyleName" inherit="no" type="String"/>
                </component>
                <component name="mx.controls.ToolTip" base="mx.core.UIComponent">
                    <style name="backgroundAlpha" inherit="no" type="Number"/>
                    <style name="backgroundColor" inherit="no" format="Color" type="uint"/>
                    <style name="backgroundDisabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="backgroundImage" inherit="no" format="File" type="Object"/>
                    <style name="backgroundSize" inherit="no" type="String"/>
                    <style name="borderColor" inherit="no" format="Color" type="uint"/>
                    <style name="borderSides" inherit="no" type="String"/>
                    <style name="borderSkin" inherit="no" type="Class"/>
                    <style name="borderStyle" inherit="no" enumeration="inset,outset,solid,none" type="String"/>
                    <style name="borderThickness" inherit="no" format="Length" type="Number"/>
                    <style name="cornerRadius" inherit="no" format="Length" type="Number"/>
                    <style name="dropShadowEnabled" inherit="no" type="Boolean"/>
                    <style name="dropShadowColor" inherit="yes" format="Color" type="uint"/>
                    <style name="shadowDirection" inherit="no" enumeration="left,center,right" type="String"/>
                    <style name="shadowDistance" inherit="no" format="Length" type="Number"/>
                    <style name="leading" inherit="no" format="Length" type="Number"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                    <style name="backgroundAlpha" inherit="no" type="Number"/>
                </component>
                <component name="mx.controls.Tree" base="mx.controls.List">
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style arrayType="uint" name="alternatingItemColors" inherit="yes" format="Color" type="Array"/>
                    <style arrayType="uint" name="depthColors" inherit="yes" format="Color" type="Array"/>
                    <style name="defaultLeafIcon" inherit="no" format="EmbeddedFile" type="Class"/>
                    <style name="disclosureOpenIcon" inherit="no" format="EmbeddedFile" type="Class"/>
                    <style name="disclosureClosedIcon" inherit="no" format="EmbeddedFile" type="Class"/>
                    <style name="folderOpenIcon" inherit="no" format="EmbeddedFile" type="Class"/>
                    <style name="folderClosedIcon" inherit="no" format="EmbeddedFile" type="Class"/>
                    <style name="indentation" inherit="no" type="Number"/>
                    <style name="openDuration" inherit="no" format="Time" type="Number"/>
                    <style name="openEasingFunction" inherit="no" type="Function"/>
                    <style name="rollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="selectionColor" inherit="yes" format="Color" type="uint"/>
                    <style name="selectionDisabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="selectionEasingFunction" inherit="no" type="Function"/>
                    <style name="textRollOverColor" inherit="yes" format="Color" type="uint"/>
                    <style name="textSelectedColor" inherit="yes" format="Color" type="uint"/>
                </component>
                <component name="mx.controls.treeClasses.TreeItemRenderer" base="mx.core.UIComponent">
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                </component>
                <component name="mx.controls.VideoDisplay" base="mx.core.UIComponent">
                    <style name="backgroundAlpha" inherit="no" type="Number"/>
                    <style name="backgroundColor" inherit="no" format="Color" type="uint"/>
                    <style name="backgroundDisabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="backgroundImage" inherit="no" format="File" type="Object"/>
                    <style name="backgroundSize" inherit="no" type="String"/>
                    <style name="borderColor" inherit="no" format="Color" type="uint"/>
                    <style name="borderSides" inherit="no" type="String"/>
                    <style name="borderSkin" inherit="no" type="Class"/>
                    <style name="borderStyle" inherit="no" enumeration="inset,outset,solid,none" type="String"/>
                    <style name="borderThickness" inherit="no" format="Length" type="Number"/>
                    <style name="cornerRadius" inherit="no" format="Length" type="Number"/>
                    <style name="dropShadowEnabled" inherit="no" type="Boolean"/>
                    <style name="dropShadowColor" inherit="yes" format="Color" type="uint"/>
                    <style name="shadowDirection" inherit="no" enumeration="left,center,right" type="String"/>
                    <style name="shadowDistance" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.controls.VRule" base="mx.core.UIComponent">
                    <style name="shadowColor" inherit="yes" format="Color" type="uint"/>
                    <style name="strokeColor" inherit="yes" format="Color" type="uint"/>
                    <style name="strokeWidth" inherit="yes" format="Length" type="Number"/>
                </component>
                <component name="mx.controls.VScrollBar" base="mx.controls.scrollClasses.ScrollBar">
                    <style name="repeatDelay" inherit="no" format="Time" type="Number"/>
                    <style name="repeatInterval" inherit="no" format="Time" type="Number"/>
                </component>
                <component name="mx.controls.VSlider" base="mx.controls.sliderClasses.Slider">
                    <style name="dataTipPlacement" inherit="no" enumeration="left, top, right, bottom" type="String"/>
                </component>
                <component name="mx.core.Application" base="mx.core.LayoutContainer">
                    <style name="modalTransparency" inherit="yes" type="Number"/>
                    <style name="modalTransparencyBlur" inherit="yes" type="Number"/>
                    <style name="modalTransparencyColor" inherit="yes" format="Color" type="uint"/>
                    <style name="modalTransparencyDuration" inherit="yes" format="Time" type="Number"/>
                    <style arrayType="Number" name="backgroundGradientAlphas" inherit="no" type="Array"/>
                    <style arrayType="uint" name="backgroundGradientColors" inherit="no" format="Color" type="Array"/>
                    <style name="paddingBottom" inherit="no" format="Length" type="Number"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.core.Container" base="mx.core.UIComponent">
                    <style name="barColor" inherit="yes" format="Color" type="uint"/>
                    <style name="backgroundAlpha" inherit="no" type="Number"/>
                    <style name="backgroundColor" inherit="no" format="Color" type="uint"/>
                    <style name="backgroundDisabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="backgroundImage" inherit="no" format="File" type="Object"/>
                    <style name="backgroundSize" inherit="no" type="String"/>
                    <style name="borderColor" inherit="no" format="Color" type="uint"/>
                    <style name="borderSides" inherit="no" type="String"/>
                    <style name="borderSkin" inherit="no" type="Class"/>
                    <style name="borderStyle" inherit="no" enumeration="inset,outset,solid,none" type="String"/>
                    <style name="borderThickness" inherit="no" format="Length" type="Number"/>
                    <style name="cornerRadius" inherit="no" format="Length" type="Number"/>
                    <style name="dropShadowEnabled" inherit="no" type="Boolean"/>
                    <style name="dropShadowColor" inherit="yes" format="Color" type="uint"/>
                    <style name="shadowDirection" inherit="no" enumeration="left,center,right" type="String"/>
                    <style name="shadowDistance" inherit="no" format="Length" type="Number"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                    <style name="backgroundAttachment" inherit="no" type="String"/>
                    <style name="disabledOverlayAlpha" inherit="no" type="Number"/>
                    <style name="horizontalScrollBarStyleName" inherit="no" type="String"/>
                    <style name="verticalScrollBarStyleName" inherit="no" type="String"/>
                    <style name="paddingBottom" inherit="no" format="Length" type="Number"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.core.LayoutContainer" base="mx.core.Container">
                    <style name="horizontalAlign" inherit="no" enumeration="left,center,right" type="String"/>
                    <style name="verticalAlign" inherit="no" enumeration="bottom,middle,top" type="String"/>
                    <style name="horizontalGap" inherit="no" format="Length" type="Number"/>
                    <style name="verticalGap" inherit="no" format="Length" type="Number"/>
                    <style name="paddingBottom" inherit="no" format="Length" type="Number"/>
                    <style name="paddingTop" inherit="no" format="Length" type="Number"/>
                </component>
                <component name="mx.core.ScrollControlBase" base="mx.core.UIComponent">
                    <style name="backgroundAlpha" inherit="no" type="Number"/>
                    <style name="backgroundColor" inherit="no" format="Color" type="uint"/>
                    <style name="backgroundDisabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="backgroundImage" inherit="no" format="File" type="Object"/>
                    <style name="backgroundSize" inherit="no" type="String"/>
                    <style name="borderColor" inherit="no" format="Color" type="uint"/>
                    <style name="borderSides" inherit="no" type="String"/>
                    <style name="borderSkin" inherit="no" type="Class"/>
                    <style name="borderStyle" inherit="no" enumeration="inset,outset,solid,none" type="String"/>
                    <style name="borderThickness" inherit="no" format="Length" type="Number"/>
                    <style name="cornerRadius" inherit="no" format="Length" type="Number"/>
                    <style name="dropShadowEnabled" inherit="no" type="Boolean"/>
                    <style name="dropShadowColor" inherit="yes" format="Color" type="uint"/>
                    <style name="shadowDirection" inherit="no" enumeration="left,center,right" type="String"/>
                    <style name="shadowDistance" inherit="no" format="Length" type="Number"/>
                    <style name="leading" inherit="no" format="Length" type="Number"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                    <style name="repeatInterval" inherit="no" format="Time" type="Number"/>
                    <style name="repeatDelay" inherit="no" format="Time" type="Number"/>
                    <style name="horizontalScrollBarStyleName" inherit="no" type="String"/>
                    <style name="verticalScrollBarStyleName" inherit="no" type="String"/>
                </component>
                <component name="mx.core.UIComponent" base="mx.core.FlexSprite">
                    <style name="bottom" inherit="no" format="Length" type="Number"/>
                    <style name="horizontalCenter" inherit="no" format="Length" type="Number"/>
                    <style name="left" inherit="no" format="Length" type="Number"/>
                    <style name="right" inherit="no" format="Length" type="Number"/>
                    <style name="top" inherit="no" format="Length" type="Number"/>
                    <style name="verticalCenter" inherit="no" format="Length" type="Number"/>
                    <style name="errorColor" inherit="yes" format="Color" type="uint"/>
                    <style name="focusBlendMode" inherit="no" type="String"/>
                    <style name="focusSkin" inherit="no" type="Class"/>
                    <style name="focusThickness" inherit="no" format="Length" type="Number"/>
                    <style name="themeColor" inherit="yes" format="Color" type="uint"/>
                </component>
                <component name="mx.core.UITextField" base="mx.core.FlexTextField">
                    <style name="leading" inherit="no" format="Length" type="Number"/>
                    <style name="paddingLeft" inherit="no" format="Length" type="Number"/>
                    <style name="paddingRight" inherit="no" format="Length" type="Number"/>
                    <style name="color" inherit="yes" format="Color" type="uint"/>
                    <style name="disabledColor" inherit="yes" format="Color" type="uint"/>
                    <style name="fontAntiAliasType" inherit="yes" enumeration="normal,advanced" type="String"/>
                    <style name="fontFamily" inherit="yes" type="String"/>
                    <style name="fontGridFitType" inherit="yes" enumeration="none,pixel,subpixel" type="String"/>
                    <style name="fontSharpness" inherit="yes" type="Number"/>
                    <style name="fontSize" inherit="yes" format="Length" type="Number"/>
                    <style name="fontStyle" inherit="yes" enumeration="normal,italic" type="String"/>
                    <style name="fontThickness" inherit="yes" type="Number"/>
                    <style name="fontWeight" inherit="yes" enumeration="normal,bold" type="String"/>
                    <style name="kerning" inherit="yes" type="Boolean"/>
                    <style name="letterSpacing" inherit="yes" type="Number"/>
                    <style name="textAlign" inherit="yes" enumeration="left,center,right" type="String"/>
                    <style name="textDecoration" inherit="no" enumeration="none,underline" type="String"/>
                    <style name="textIndent" inherit="yes" format="Length" type="Number"/>
                </component>
                <component name="mx.managers.CursorManager">
                    <style name="busyCursor" inherit="no" type="Class"/>
                </component>
                <component name="mx.managers.DragManager">
                    <style name="copyCursor" inherit="no" type="Class"/>
                    <style name="defaultDragImageSkin" inherit="no" type="Class"/>
                    <style name="linkCursor" inherit="no" type="Class"/>
                    <style name="moveCursor" inherit="no" type="Class"/>
                    <style name="rejectCursor" inherit="no" type="Class"/>
                </component>
            </components>
}
}