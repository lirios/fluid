// SPDX-FileCopyrightText: 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QColor>
#include <QtQml/QQmlEngine>
#include <QtQuickControls2/QQuickAttachedPropertyPropagator>

class FluidStyle : public QQuickAttachedPropertyPropagator
{
    Q_OBJECT
    Q_DISABLE_COPY(FluidStyle)

    Q_PROPERTY(Theme theme READ theme WRITE setTheme RESET resetTheme NOTIFY themeChanged FINAL)
    Q_PROPERTY(int elevation READ elevation WRITE setElevation RESET resetElevation NOTIFY
                       elevationChanged FINAL)

    // Fonts
    Q_PROPERTY(QString brandFontFamily READ brandFontFamily CONSTANT FINAL)
    Q_PROPERTY(QString plainFontFamily READ plainFontFamily CONSTANT FINAL)

    // Color properties - Primary
    Q_PROPERTY(QColor primaryColor READ primaryColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor onPrimaryColor READ onPrimaryColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor primaryContainerColor READ primaryContainerColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(
            QColor onPrimaryContainerColor READ onPrimaryContainerColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor primaryFixedColor READ primaryFixedColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor primaryFixedDimColor READ primaryFixedDimColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor onPrimaryFixedColor READ onPrimaryFixedColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor onPrimaryFixedVariantColor READ onPrimaryFixedVariantColor NOTIFY themeChanged
                       FINAL)

    // Color properties - Secondary
    Q_PROPERTY(QColor secondaryColor READ secondaryColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor onSecondaryColor READ onSecondaryColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(
            QColor secondaryContainerColor READ secondaryContainerColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor onSecondaryContainerColor READ onSecondaryContainerColor NOTIFY themeChanged
                       FINAL)

    // Color properties - Tertiary
    Q_PROPERTY(QColor tertiaryColor READ tertiaryColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor onTertiaryColor READ onTertiaryColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor tertiaryContainerColor READ tertiaryContainerColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(
            QColor onTertiaryContainerColor READ onTertiaryContainerColor NOTIFY themeChanged FINAL)

    // Color properties - Error
    Q_PROPERTY(QColor errorColor READ errorColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor onErrorColor READ onErrorColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor errorContainerColor READ errorContainerColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor onErrorContainerColor READ onErrorContainerColor NOTIFY themeChanged FINAL)

    // Color properties - Background
    Q_PROPERTY(QColor backgroundColor READ backgroundColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor onBackgroundColor READ onBackgroundColor NOTIFY themeChanged FINAL)

    // Color properties - Surface
    Q_PROPERTY(QColor surfaceColor READ surfaceColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor onSurfaceColor READ onSurfaceColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor surfaceBrightColor READ surfaceBrightColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor surfaceDimColor READ surfaceDimColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor surfaceVariantColor READ surfaceVariantColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor onSurfaceVariantColor READ onSurfaceVariantColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor surfaceContainerLowestColor READ surfaceContainerLowestColor NOTIFY
                       themeChanged FINAL)
    Q_PROPERTY(
            QColor surfaceContainerLowColor READ surfaceContainerLowColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor surfaceContainerColor READ surfaceContainerColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor surfaceContainerHighColor READ surfaceContainerHighColor NOTIFY themeChanged
                       FINAL)
    Q_PROPERTY(QColor surfaceContainerHighestColor READ surfaceContainerHighestColor NOTIFY
                       themeChanged FINAL)

    // Color properties - Outline
    Q_PROPERTY(QColor outlineColor READ outlineColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor outlineVariantColor READ outlineVariantColor NOTIFY themeChanged FINAL)

    // Color properties - Inverse
    Q_PROPERTY(QColor inverseSurfaceColor READ inverseSurfaceColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor inverseOnSurfaceColor READ inverseOnSurfaceColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor inversePrimaryColor READ inversePrimaryColor NOTIFY themeChanged FINAL)

    // Color properties - Scrim
    Q_PROPERTY(QColor scrimColor READ scrimColor NOTIFY themeChanged FINAL)

    // Color properties - Shadow
    Q_PROPERTY(QColor shadowColor READ shadowColor NOTIFY themeChanged FINAL)

    QML_NAMED_ELEMENT(Style)
    QML_ATTACHED(FluidStyle)
    QML_UNCREATABLE("")
    QML_ADDED_IN_VERSION(2, 0)
public:
    enum Theme {
        Light,
        Dark,
        System
    };
    Q_ENUM(Theme)

    enum class TypeFace {
        Brand,
        Plain
    };
    Q_ENUM(TypeFace)

    explicit FluidStyle(QObject *parent = nullptr);

    Theme theme() const;
    void setTheme(Theme theme);
    void resetTheme();

    int elevation() const;
    void setElevation(int elevation);
    void resetElevation();

    // Font getters
    QString brandFontFamily() const;
    QString plainFontFamily() const;

    // Color getters - Primary
    QColor primaryColor() const;
    QColor onPrimaryColor() const;
    QColor primaryContainerColor() const;
    QColor onPrimaryContainerColor() const;
    QColor primaryFixedColor() const;
    QColor primaryFixedDimColor() const;
    QColor onPrimaryFixedColor() const;
    QColor onPrimaryFixedVariantColor() const;

    // Color getters - Secondary
    QColor secondaryColor() const;
    QColor onSecondaryColor() const;
    QColor secondaryContainerColor() const;
    QColor onSecondaryContainerColor() const;

    // Color getters - Tertiary
    QColor tertiaryColor() const;
    QColor onTertiaryColor() const;
    QColor tertiaryContainerColor() const;
    QColor onTertiaryContainerColor() const;

    // Color getters - Error
    QColor errorColor() const;
    QColor onErrorColor() const;
    QColor errorContainerColor() const;
    QColor onErrorContainerColor() const;

    // Color getters - Background
    QColor backgroundColor() const;
    QColor onBackgroundColor() const;

    // Color getters - Surface
    QColor surfaceColor() const;
    QColor onSurfaceColor() const;
    QColor surfaceBrightColor() const;
    QColor surfaceDimColor() const;
    QColor surfaceVariantColor() const;
    QColor onSurfaceVariantColor() const;
    QColor surfaceContainerLowestColor() const;
    QColor surfaceContainerLowColor() const;
    QColor surfaceContainerColor() const;
    QColor surfaceContainerHighColor() const;
    QColor surfaceContainerHighestColor() const;

    // Color getters - Outline
    QColor outlineColor() const;
    QColor outlineVariantColor() const;

    // Color getters - Inverse
    QColor inverseSurfaceColor() const;
    QColor inverseOnSurfaceColor() const;
    QColor inversePrimaryColor() const;

    // Color getters - Scrim
    QColor scrimColor() const;

    // Color getters - Shadow
    QColor shadowColor() const;

    static FluidStyle *qmlAttachedProperties(QObject *object);

    static bool isDarkSystemTheme();
    static Theme effectiveTheme(Theme theme);

Q_SIGNALS:
    void themeChanged();
    void elevationChanged();

protected:
    void attachedParentChange(QQuickAttachedPropertyPropagator *newParent,
                              QQuickAttachedPropertyPropagator *oldParent) override;

private:
    // Whether a particular setting was explicitly set on this instance
    bool m_explicitTheme = false;

    // Actual property values
    bool m_systemTheme = false;
    FluidStyle::Theme m_theme = FluidStyle::Light;
    int m_elevation = 0;

    void inheritTheme(FluidStyle::Theme theme);
    void propagateTheme();
};
