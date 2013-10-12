/**
 * FlexSpy 1.4-beta
 *
 * <p>Code released under WTFPL [http://sam.zoy.org/wtfpl/]</p>
 * @author Arnaud Pichery [http://coderpeon.ovh.org]
 * @author Frédéric Thomas
 */
package com.flexspy.impl {

import flash.display.Graphics;

import mx.core.UIComponent;

/**
 * Components that draws a yellow rectangle.
 */
public class HighlightRectangle extends UIComponent {

    /**
     *  Draws the object and/or sizes and positions its children.
     *
     *  @param unscaledWidth Specifies the width of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleX</code> property of the component.
     *
     *  @param unscaledHeight Specifies the height of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleY</code> property of the component.
     */
    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
        super.updateDisplayList(unscaledWidth, unscaledHeight);

        var g:Graphics = this.graphics;
        g.clear();
        g.lineStyle(2, 0xFFFF00, 1.0);
        g.drawRect(0, 0, unscaledWidth, unscaledHeight);
    }
}
}