/**
 * FlexSpy 1.4-beta
 *
 * <p>Code released under WTFPL [http://sam.zoy.org/wtfpl/]</p>
 * @author Arnaud Pichery [http://coderpeon.ovh.org]
 * @author Frédéric Thomas
 */
package com.flexspy.impl.metadata {

/**
 * Represent the content of a style metadata tag
 */
public class StyleMetadata {

    /**
     * Constructor
     */
    public function StyleMetadata(xml:XML) {
        name = xml.@name;
        type = xml.@type;
        arrayType = xml.@arrayType;
        format = xml.@format;
        enumeration = xml.@enumeration;
    }

    /** Specifies the name of the style. */
    public var name:String;

    /** Specifies the data type of the value that you write to the style property. If the type is not an ActionScript type such as Number or Date, use a qualified class name in the form packageName.className. */
    public var type:String;

    /** If type is Array, arrayType specifies the data type of the Array elements. If the data type is not an ActionScript type such as Number or Date, use a qualified class name in the form packageName.className. */
    public var arrayType:String;

    /** Specifies the units of the property. For example, if you specify type as "Number", you might specify format="Length" if the style defines a length measured in pixels. Or, if you specify type="uint", you might set format="Color" if the style defines an RGB color. */
    public var format:String;

    /** Specifies an enumerated list of possible values for the style property. */
    public var enumeration:String;
}
}