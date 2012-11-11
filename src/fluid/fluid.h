/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 * Copyright (c) 2005 Aaron Seigo
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *    Aaron Seigo <aseigo@kde.org>
 *
 * $BEGIN_LICENSE:LGPL2.1+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

#ifndef FLUID_H
#define FLUID_H

/** @header plasma/plasma.h <FluidUi/FluidUi> */

#include <QPainterPath>

#include <Fluid/FluidExport>

class QAction;

/**
 * Namespace for everything in libplasma
 */
namespace Fluid
{
    /**
     * The Constraint enumeration lists the various constraints that FluidUi
     * objects have managed for them and which they may wish to react to,
     * for instance in Applet::constraintsUpdated
     */
    enum Constraint {
        NoConstraint = 0, /**< No constraint; never passed in to Applet::constraintsEvent on its own */
        FormFactorConstraint = 1, /**< The FormFactor for an object */
        LocationConstraint = 2, /**< The Location of an object */
        ScreenConstraint = 4, /**< Which screen an object is on */
        SizeConstraint = 8, /**< the size of the applet was changed */
        ImmutableConstraint = 16, /**< the immutability (locked) nature of the applet changed  */
        StartupCompletedConstraint = 32, /**< application startup has completed */
        ContextConstraint = 64, /**< the context (e.g. activity) has changed */
        PopupConstraint = 128, /**< the position of the popup needs to be recalculated*/
        AllConstraints = FormFactorConstraint | LocationConstraint | ScreenConstraint |
                         SizeConstraint | ImmutableConstraint | PopupConstraint
    };
    Q_DECLARE_FLAGS(Constraints, Constraint)

    /**
     * The FormFactor enumeration describes how a FluidUi::Applet should arrange
     * itself. The value is derived from the container managing the Applet
     * (e.g. in FluidUi, a Corona on the desktop or on a panel).
     **/
    enum FormFactor {
        Planar = 0,  /**< The applet lives in a plane and has two
                    degrees of freedom to grow. Optimize for
                    desktop, laptop or tablet usage: a high
                    resolution screen 1-3 feet distant from the
                    viewer. */
        MediaCenter, /**< As with Planar, the applet lives in a plane
                    but the interface should be optimized for
                    medium-to-high resolution screens that are
                    5-15 feet distant from the viewer. Sometimes
                    referred to as a "ten foot interface".*/
        Horizontal,  /**< The applet is constrained vertically, but
                    can expand horizontally. */
        Vertical     /**< The applet is constrained horizontally, but
                    can expand vertically. */
    };

    /**
     * The Direction enumeration describes in which direction, relative to the
     * Applet (and its managing container), popup menus, expanders, balloons,
     * message boxes, arrows and other such visually associated widgets should
     * appear in. This is usually the oposite of the Location.
     **/
    enum Direction {
        Down = 0, /**< Display downards */
        Up,       /**< Display upwards */
        Left,     /**< Display to the left */
        Right     /**< Display to the right */
    };

    /**
     * The Location enumeration describes where on screen an element, such as an
     * Applet or its managing container, is positioned on the screen.
     **/
    enum Location {
        Floating = 0, /**< Free floating. Neither geometry or z-ordering
                     is described precisely by this value. */
        Desktop,      /**< On the planar desktop layer, extending across
                     the full screen from edge to edge */
        FullScreen,   /**< Full screen */
        TopEdge,      /**< Along the top of the screen*/
        BottomEdge,   /**< Along the bottom of the screen*/
        LeftEdge,     /**< Along the left side of the screen */
        RightEdge     /**< Along the right side of the screen */
    };

    /**
     * The position enumeration
     *
     **/
    enum Position {
        LeftPositioned,    /**< Positioned left */
        RightPositioned,   /**< Positioned right */
        TopPositioned,     /**< Positioned top */
        BottomPositioned,  /**< Positioned bottom */
        CenterPositioned   /**< Positioned in the center */
    };

    /**
     * The popup position enumeration relatively to his attached widget
     *
     **/

    enum PopupPlacement {
        FloatingPopup = 0,            /**< Free floating, non attached popup */
        TopPosedLeftAlignedPopup,     /**< Popup positioned on the top, aligned
                                     to the left of the wigdet */
        TopPosedRightAlignedPopup,    /**< Popup positioned on the top, aligned
                                     to the right of the widget */
        LeftPosedTopAlignedPopup,     /**< Popup positioned on the left, aligned
                                     to the right of the wigdet */
        LeftPosedBottomAlignedPopup,  /**< Popup positioned on the left, aligned
                                     to the bottom of the widget */
        BottomPosedLeftAlignedPopup,  /**< Popup positioned on the bottom, aligned
                                     to the left of the wigdet */
        BottomPosedRightAlignedPopup, /**< Popup positioned on the bottom, aligned
                                     to the right of the widget */
        RightPosedTopAlignedPopup,    /**< Popup positioned on the right, aligned
                                     to the top of the wigdet */
        RightPosedBottomAlignedPopup  /**< Popup positioned on the right, aligned
                                     to the bottom of the widget */
    };

    /**
     * Flip enumeration
     */
    enum FlipDirection {
        NoFlip = 0,          /**< Do not flip */
        HorizontalFlip = 1,  /**< Flip horizontally */
        VerticalFlip = 2     /**< Flip vertically */
    };
    Q_DECLARE_FLAGS(Flip, FlipDirection)

    /**
     * Possible timing alignments
     **/
    enum IntervalAlignment {
        NoAlignment = 0, /**< No alignment **/
        AlignToMinute, /**< Align to the minute **/
        AlignToHour /**< Align to the hour **/
    };

    enum ItemTypes {
        AppletType = 1,
        LineEditType = 2
    };

    /**
     * Defines the immutability of items like applets, corona and containments
     * they can be free to modify, locked down by the user or locked down by the
     * system (e.g. kiosk setups).
     */
    enum ImmutabilityType {
        Mutable = 1,        /**< The item can be modified in any way **/
        UserImmutable = 2,  /**< The user has requested a lock down, and can undo
                           the lock down at any time **/
        SystemImmutable = 4 /**<  the item is locked down by the system, the user
                           can't unlock it **/
    };

    /**
     * Defines the aspect ratio used when resizing an applet
     */
    enum AspectRatioMode {
        InvalidAspectRatioMode = -1, /**< Unset mode used for dev convenience
                                    when there is a need to store the
                                    aspectRatioMode somewhere */
        IgnoreAspectRatio = 0,       /**< The applet can be freely resized */
        KeepAspectRatio = 1,         /**< The applet keeps a fixed aspect ratio */
        Square = 2,                  /**< The applet is always a square */
        ConstrainedSquare = 3,       /**< The applet is no wider (in horizontal
                                    formfactors) or no higher (in vertical
                                    ones) than a square */
        FixedSize = 4                /** The applet cannot be resized */
    };

    /**
     * The ComonentType enumeration refers to the various types of components,
     * or plugins, supported by plasma.
     */
    enum ComponentType {
        AppletComponent = 1,      /**< FluidUi::Applet based plugins **/
        DataEngineComponent = 2,  /**< FluidUi::DataEngine based plugins **/
        RunnerComponent = 4,      /**< FluidUi::AbstractRunner based plugsin **/
        AnimatorComponent = 8,    /**< FluidUi::Animator based plugins **/
        ContainmentComponent = 16,/**< FluidUi::Containment based plugins **/
        WallpaperComponent = 32,   /**< FluidUi::Wallpaper based plugins **/
        GenericComponent = 64      /** Generic repositories of files, usually they keep QML files and their assets **/
    };
    Q_DECLARE_FLAGS(ComponentTypes, ComponentType)

    enum MarginEdge {
        TopMargin = 0, /**< The top margin **/
        BottomMargin, /**< The bottom margin **/
        LeftMargin, /**< The left margin **/
        RightMargin /**< The right margin **/
    };

    enum MessageButton {
        ButtonNone = 0, /**< None **/
        ButtonOk = 1, /**< OK Button **/
        ButtonYes = 2, /**< Yes Button **/
        ButtonNo = 4, /**< No Button **/
        ButtonCancel = 8 /**< Cancel Button **/
    };
    Q_DECLARE_FLAGS(MessageButtons, MessageButton)

    /**
     * Status of an applet
     * @since 4.3
     */
    enum ItemStatus {
        UnknownStatus = 0, /**< The status is unknown **/
        PassiveStatus = 1, /**< The Item is passive **/
        ActiveStatus = 2, /**< The Item is active **/
        NeedsAttentionStatus = 3, /**< The Item needs attention **/
        AcceptingInputStatus = 4 /**< The Item is accepting input **/
    };
    Q_ENUMS(ItemStatus)

    enum AnnouncementMethod {
        NoAnnouncement = 0, /**< No announcements **/
        ZeroconfAnnouncement = 1 /**< Announcements via ZeroConf **/
    };
    Q_DECLARE_FLAGS(AnnouncementMethods, AnnouncementMethod)

    enum TrustLevel {
        UnverifiableTrust = 0,      /**< The trust of the object can not be verified, usually because no
                                     trust information (e.g. a cryptographic signature) was provided */
        CompletelyUntrusted,        /**< The signature is broken/expired/false */
        UnknownTrusted,             /**< The signature is valid, but the key is unknown */
        UserTrusted,                /**< The signature is valid and made with a key signed by one of the
                                     user's own keys*/
        SelfTrusted,                /**< The signature is valid and made with one of the user's own keys*/
        FullyTrusted,               /**< The signature is valid and made with a key signed by the vendor's key*/
        UltimatelyTrusted           /**< The signature is valid and made with the vendor's key*/
    };
    Q_ENUMS(TrustLevel)

    /**
     * Description on how draw a background for the applet
     */
    enum BackgroundHints {
        NoBackground = 0,         /**< Not drawing a background under the applet, the applet has its own implementation */
        StandardBackground = 1,   /**< The standard background from the theme is drawn */
        TranslucentBackground = 2, /**< An alternate version of the background is drawn, usually more translucent */
        DefaultBackground = StandardBackground /**< Default settings: both standard background */
    };
    Q_ENUMS(BackgroundHints)

    /**
     * Converts a location to a direction. Handy for figuring out which way to send a popup based on
     * location or to point arrows and other directional items.
     *
     * @param location the location of the container the element will appear in
     * @return the visual direction the element should be oriented in
     **/
    FLUID_EXPORT Direction locationToDirection(Location location);

    /**
     * Converts a location to the direction facing it. Handy for figuring out which way to collapse
     * a popup or to point arrows at the item itself.
     *
     * @param location the location of the container the element will appear in
     * @return the visual direction the element should be oriented in
     **/
    FLUID_EXPORT Direction locationToInverseDirection(Location location);
}

Q_DECLARE_OPERATORS_FOR_FLAGS(Fluid::Constraints)
Q_DECLARE_OPERATORS_FOR_FLAGS(Fluid::Flip)
Q_DECLARE_OPERATORS_FOR_FLAGS(Fluid::ComponentTypes)
Q_DECLARE_OPERATORS_FOR_FLAGS(Fluid::MessageButtons)

#endif // FLUID_H
