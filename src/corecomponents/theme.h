/*
 *   Copyright 2006-2007 Aaron Seigo <aseigo@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#ifndef FLUID_THEME_H
#define FLUID_THEME_H

#include <QObject>
#include <QFont>
#include <QFontMetrics>

#include <Fluid/FluidExport>

namespace Fluid
{
    class ThemePrivate;

    /**
     * @class Theme plasma/theme.h <Fluid/Theme>
     *
     * @short Interface to the Fluid theme
     *
     * Accessed via Fluid::Theme::defaultTheme() e.g:
     * \code
     * QString imagePath = Fluid::Theme::defaultTheme()->imagePath("widgets/clock")
     * \endcode
     *
     * Fluid::Theme provides access to a common and standardized set of graphic
     * elements stored in SVG format. This allows artists to create single packages
     * of SVGs that will affect the look and feel of all workspace components.
     *
     * Fluid::Svg uses Fluid::Theme internally to locate and load the appropriate
     * SVG data. Alternatively, Fluid::Theme can be used directly to retrieve
     * file system paths to SVGs by name.
     */
    class FLUID_CORECOMPONENTS_EXPORT Theme : public QObject
    {
        Q_OBJECT
        Q_PROPERTY(QString themeName READ themeName)

    public:
        enum ColorRole {
            TextColor = 0, /**<  the text color to be used by items resting on the background */
            HighlightColor = 1, /**<  the text higlight color to be used by items resting
                                   on the background */
            BackgroundColor = 2, /**< the default background color */
            ButtonTextColor = 4, /** text color for buttons */
            ButtonBackgroundColor = 8, /** background color for buttons*/
            LinkColor = 16, /** color for clickable links */
            VisitedLinkColor = 32, /** color visited clickable links */
            ButtonHoverColor = 64, /** color for hover effect on buttons */
            ButtonFocusColor = 128, /** color for focus effect on buttons */
            ViewTextColor = 256, /** text color for views */
            ViewBackgroundColor = 512, /** background color for views */
            ViewHoverColor = 1024, /** color for hover effect on view */
            ViewFocusColor = 2048 /** color for focus effect on view */
        };

        enum FontRole {
            DefaultFont = 0, /**< The standard text font */
            DesktopFont, /**< The standard text font */
            SmallestFont /**< The smallest readable font */
        };

        /**
         * Singleton pattern accessor
         **/
        static Theme *defaultTheme();

        /**
         * Default constructor. Usually you want to use the singleton instead.
         * @see defaultTheme
         * @param parent the parent object
         */
        explicit Theme(QObject *parent = 0);

        /**
         * Construct a theme. Usually you want to use the singleton instead.
         * @see defaultTheme
         * @param themeName the name of the theme to create
         * @param parent the parent object
         * @since 4.3
         */
        explicit Theme(const QString &themeName, QObject *parent = 0);

        ~Theme();

        /**
         * @return a list of all known themes
         * @since 4.3
         */
        static QStringList listThemeInfo();

        /**
         * Sets the current theme being used.
         */
        void setThemeName(const QString &themeName);

        /**
         * @return the name of the theme.
         */
        QString themeName() const;

        /**
         * Retrieve the path for an SVG image in the current theme.
         *
         * @param name the name of the file in the theme directory (without the
         *           ".svg" part or a leading slash)
         * @return the full path to the requested file for the current theme
         */
        Q_INVOKABLE QString imagePath(const QString &name) const;

        /**
         * Checks if this theme has an image named in a certain way
         *
         * @param name the name of the file in the theme directory (without the
         *           ".svg" part or a leading slash)
         * @return true if the image exists for this theme
         */
        Q_INVOKABLE bool currentThemeHasImage(const QString &name) const;

#if 0
        /**
         * Returns the color scheme configurationthat goes along this theme.
         * This can be used with KStatefulBrush and KColorScheme to determine
         * the proper colours to use along with the visual elements in this theme.
         */
        Q_INVOKABLE KSharedConfigPtr colorScheme() const;

        /**
         * Returns the text color to be used by items resting on the background
         *
         * @param role which role (usage pattern) to get the color for
         */
        Q_INVOKABLE QColor color(ColorRole role) const;
#endif

        /**
         * Sets the default font to be used with themed items. Defaults to
         * the application wide default font.
         *
         * @param font the new font
         * @param role which role (usage pattern) to set the font for
         */
        Q_INVOKABLE void setFont(const QFont &font, FontRole role = DefaultFont);

        /**
         * Returns the font to be used by themed items
         *
         * @param role which role (usage pattern) to get the font for
         */
        Q_INVOKABLE QFont font(FontRole role) const;

        /**
         * Returns the font metrics for the font to be used by themed items
         */
        Q_INVOKABLE QFontMetrics fontMetrics() const;

        /**
         * Returns if the window manager effects (e.g. translucency, compositing) is active or not
         */
        Q_INVOKABLE bool windowTranslucencyEnabled() const;

        /**
         * Tells the theme whether to follow the global settings or use application
         * specific settings
         *
         * @param useGlobal pass in true to follow the global settings
         */
        void setUseGlobalSettings(bool useGlobal);

        /**
         * @return true if the global settings are followed, false if application
         * specific settings are used.
         */
        bool useGlobalSettings() const;

        /**
         * @return true if the native widget styles should be used instead of themed
         * widgets. Defaults is false.
         */
        bool useNativeWidgetStyle() const;

        /**
         * Provides a Fluid::Theme-themed stylesheet for hybrid (web / native Fluid) widgets.
         *
         * You can use this method to retrieve a basic default stylesheet, or to theme your
         * custom stylesheet you use for example in Fluid::WebView. The QString you can pass
         * into this method does not have to be a valid stylesheet, in fact you can use this
         * method to replace color placeholders with the theme's color in any QString.
         *
         * In order to use this method with a custom stylesheet, just put for example %textcolor
         * in your QString and it will be replaced with the theme's text (or foreground) color.
         *
         * Just like in many other methods for retrieving theme information, do not forget to
         * update your stylesheet upon the themeChanged() signal.
         *
         * The following tags will be replaced by corresponding colors from Fluid::Theme:
         *
         * %textcolor
         * %backgroundcolor
         * %buttonbackgroundcolor
         *
         * %link
         * %activatedlink
         * %hoveredlink
         * %visitedlink
         *
         * %fontfamily
         * %fontsize
         * %smallfontsize
         *
         * @param css a stylesheet to theme, leave empty for a default stylesheet containing
         * theming for some commonly used elements, body text and links, for example.
         *
         * @return a piece of CSS that sets the most commonly used style elements to a theme
         * matching Fluid::Theme.
         *
         * @since 4.5
         */
        Q_INVOKABLE QString styleSheet(const QString &css = QString()) const;


        /**
         * This is an overloaded member provided to check with file timestamp
         * where cache is still valid.
         *
         * @param key the name to use in the cache for this image
         * @param pix the pixmap object to populate with the resulting data if found
         * @param lastModified if non-zero, the time stamp is also checked on the file,
         *                     and must be newer than the timestamp to be loaded
         *
         * @return true when pixmap was found and loaded from cache, false otherwise
         * @since 4.3
         **/
        bool findInCache(const QString &key, QPixmap &pix, unsigned int lastModified = 0);

        /**
         * Insert specified pixmap into the cache.
         * If the cache already contains pixmap with the specified key then it is
         * overwritten.
         *
         * @param key the name to use in the cache for this pixmap
         * @param pix the pixmap data to store in the cache
         **/
        void insertIntoCache(const QString &key, const QPixmap &pix);

        /**
         * Insert specified pixmap into the cache.
         * If the cache already contains pixmap with the specified key then it is
         * overwritten.
         * The actual insert is delayed for optimization reasons and the id
         * parameter is used to discard repeated inserts in the delay time, useful
         * when for instance the graphics to inser comes from a quickly resizing
         * object: the frames between the start and destination sizes aren't
         * useful in the cache and just cause overhead.
         *
         * @param key the name to use in the cache for this pixmap
         * @param pix the pixmap data to store in the cache
         * @param id a name that identifies the caller class of this function in an unique fashion.
         *           This is needed to limit disk writes of the cache.
         *           If an image with the same id changes quickly,
         *           only the last size where insertIntoCache was called is actually stored on disk
         * @since 4.3
         **/
        void insertIntoCache(const QString &key, const QPixmap &pix, const QString &id);

        /**
         * Sets the maximum size of the cache (in kilobytes). If cache gets bigger
         * the limit then some entries are removed
         * Setting cache limit to 0 disables automatic cache size limiting.
         *
         * Note that the cleanup might not be done immediately, so the cache might
         *  temporarily (for a few seconds) grow bigger than the limit.
         **/
        void setCacheLimit(int kbytes);

        /**
         * Tries to load the rect of a sub element from a disk cache
         *
         * @param image path of the image we want to check
         * @param element sub element we want to retrieve
         * @param rect output parameter of the element rect found in cache
         *           if not found or if we are sure it doesn't exist it will be QRect()
         * @return true if the element was found in cache or if we are sure the element doesn't exist
         **/
        bool findInRectsCache(const QString &image, const QString &element, QRectF &rect) const;

        /**
         * Returns a list of all keys of cached rects for the given image.
         *
         * @param image path of the image for which the keys should be returned
         *
         * @return a QStringList whose elements are the entry keys in the rects cache
         *
         * @since 4.6
         */
        QStringList listCachedRectKeys(const QString &image) const;

        /**
         * Inserts a rectangle of a sub element of an image into a disk cache
         *
         * @param image path of the image we want to insert information
         * @param element sub element we want insert the rect
         * @param rect element rectangle
         **/
        void insertIntoRectsCache(const QString &image, const QString &element, const QRectF &rect);

        /**
         * Discards all the information about a given image from the rectangle disk cache
         *
         * @param image the path to the image the cache is assoiated with
         **/
        void invalidateRectsCache(const QString &image);

        /**
         * Frees up memory used by cached information for a given image without removing
         * the permenant record of it on disk.
         * @see invalidateRectsCache
         *
         * @param image the path to the image the cache is assoiated with
         */
        void releaseRectsCache(const QString &image);

        /**
         * @return the default homepage to use in conjunction with the branding svg content
         * @since 4.7
         */
        QUrl homepage() const;

        /**
         * @return the default tool tip delay; -1 means "no tooltips"
         */
        int toolTipDelay() const;

    Q_SIGNALS:
        /**
         * Emitted when the user changes the theme. Stylesheet usage, colors, etc. should
         * be updated at this point. However, SVGs should *not* be repainted in response
         * to this signal; connect to Svg::repaintNeeded() instead for that, as Svg objects
         * need repainting not only when themeChanged() is emitted; moreover Svg objects
         * connect to and respond appropriately to themeChanged() internally, emitting
         * Svg::repaintNeeded() at an appropriate time.
         */
        void themeChanged();

    public Q_SLOTS:
        /**
         * Notifies the Theme object that the theme settings have changed
         * and should be read from the config file
         **/
        void settingsChanged();

    private:
        friend class ThemeSingleton;
        friend class ThemePrivate;
        ThemePrivate *const d;

        Q_PRIVATE_SLOT(d, void compositingChanged(bool))
        Q_PRIVATE_SLOT(d, void colorsChanged())
        Q_PRIVATE_SLOT(d, void blurBehindChanged(bool blur))
        Q_PRIVATE_SLOT(d, void settingsChanged(const QString &key, const QVariant &value))
        Q_PRIVATE_SLOT(d, void scheduledCacheUpdate())
        Q_PRIVATE_SLOT(d, void onAppExitCleanup())
        Q_PRIVATE_SLOT(d, void notifyOfChanged())
    };
} // Fluid namespace

#endif // FLUID_THEME_H
