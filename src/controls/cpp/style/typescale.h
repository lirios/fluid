// Copyright (C) 2025 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#pragma once

#include <QFont>
#include <QQmlEngine>

#include "../enum.h"

namespace Fluid {

/*!
    \brief Type scale definition for typography tokens.

    Provides access to font size and line height for a specific type scale.

    \code{.qml}
    import QtQuick
    import Fluid as MD

    Text {
        text: "Hello, World!"
        font.pixelSize: MD.Tokens.typescale.bodyLarge.fontSize
        lineHeight: MD.Tokens.typescale.bodyLarge.lineHeight
    }
    \endcode
*/
struct TypeScaleValue
{
    Q_GADGET
    QML_ELEMENT
    QML_VALUE_TYPE(typescale)

    Q_PROPERTY(TypeFace::TypeFace face MEMBER face CONSTANT FINAL)
    Q_PROPERTY(qint32 fontSize MEMBER fontSize CONSTANT FINAL)
    Q_PROPERTY(qint32 lineHeight MEMBER lineHeight CONSTANT FINAL)
    Q_PROPERTY(QFont::Weight fontWeight MEMBER fontWeight CONSTANT FINAL)
    Q_PROPERTY(qreal tracking MEMBER tracking CONSTANT FINAL)
    Q_PROPERTY(qint32 wght READ wght CONSTANT FINAL)
    Q_PROPERTY(qint32 grad READ grad CONSTANT FINAL)
    Q_PROPERTY(qint32 wdth READ wdth CONSTANT FINAL)
    Q_PROPERTY(qint32 rond READ rond CONSTANT FINAL)
    Q_PROPERTY(qint32 opsz READ opsz CONSTANT FINAL)
    Q_PROPERTY(qint32 crsv READ crsv CONSTANT FINAL)
    Q_PROPERTY(qint32 slnt READ slnt CONSTANT FINAL)
    Q_PROPERTY(qint32 fill READ fill CONSTANT FINAL)
    Q_PROPERTY(qint32 hexp READ hexp CONSTANT FINAL)
public:
    TypeFace::TypeFace face = TypeFace::TypeFace::Plain;
    qint32 fontSize = 14;
    qint32 lineHeight = 24;
    QFont::Weight fontWeight = QFont::Weight::Normal;
    qreal tracking = 0.0;

    qint32 wght() const
    {
        return static_cast<qint32>(fontWeight);
    }

    qint32 grad() const
    {
        return 0;
    }

    qint32 wdth() const
    {
        return 100;
    }

    qint32 rond() const
    {
        return 0;
    }

    qint32 opsz() const
    {
        return fontSize;
    }

    qint32 crsv() const
    {
        return 0;
    }

    qint32 slnt() const
    {
        return 0;
    }

    qint32 fill() const
    {
        return 0;
    }

    qint32 hexp() const
    {
        return 0;
    }
};

/*!
    \brief Material Design 3 type scale tokens.

    Provides access to Material Design 3 type scale definitions that can be used from QML.

    \code{.qml}
    import QtQuick
    import Fluid as MD

    Text {
        text: "Hello, World!"
        font.pixelSize: MD.Tokens.typescale.bodyLarge.fontSize
        lineHeight: MD.Tokens.typescale.bodyLarge.lineHeight
    }
    \endcode

    For more information see the
    <a href="https://m3.material.io/styles/typography/type-scale-tokens">Material Design 3
   typography guidelines</a>.
*/
class TypeScale : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    Q_PROPERTY(TypeScaleValue displayLarge READ displayLarge CONSTANT FINAL)
    Q_PROPERTY(TypeScaleValue displayMedium READ displayMedium CONSTANT FINAL)
    Q_PROPERTY(TypeScaleValue displaySmall READ displaySmall CONSTANT FINAL)
    Q_PROPERTY(TypeScaleValue headlineLarge READ headlineLarge CONSTANT FINAL)
    Q_PROPERTY(TypeScaleValue headlineMedium READ headlineMedium CONSTANT FINAL)
    Q_PROPERTY(TypeScaleValue headlineSmall READ headlineSmall CONSTANT FINAL)
    Q_PROPERTY(TypeScaleValue titleLarge READ titleLarge CONSTANT FINAL)
    Q_PROPERTY(TypeScaleValue titleMedium READ titleMedium CONSTANT FINAL)
    Q_PROPERTY(TypeScaleValue titleSmall READ titleSmall CONSTANT FINAL)
    Q_PROPERTY(TypeScaleValue bodyLarge READ bodyLarge CONSTANT FINAL)
    Q_PROPERTY(TypeScaleValue bodyMedium READ bodyMedium CONSTANT FINAL)
    Q_PROPERTY(TypeScaleValue bodySmall READ bodySmall CONSTANT FINAL)
    Q_PROPERTY(TypeScaleValue labelLarge READ labelLarge CONSTANT FINAL)
    Q_PROPERTY(TypeScaleValue labelMedium READ labelMedium CONSTANT FINAL)
    Q_PROPERTY(TypeScaleValue labelSmall READ labelSmall CONSTANT FINAL)
public:
    explicit TypeScale(QObject *parent = nullptr);

    TypeScaleValue displayLarge() const;
    TypeScaleValue displayMedium() const;
    TypeScaleValue displaySmall() const;
    TypeScaleValue headlineLarge() const;
    TypeScaleValue headlineMedium() const;
    TypeScaleValue headlineSmall() const;
    TypeScaleValue titleLarge() const;
    TypeScaleValue titleMedium() const;
    TypeScaleValue titleSmall() const;
    TypeScaleValue bodyLarge() const;
    TypeScaleValue bodyMedium() const;
    TypeScaleValue bodySmall() const;
    TypeScaleValue labelLarge() const;
    TypeScaleValue labelMedium() const;
    TypeScaleValue labelSmall() const;

protected:
    TypeScaleValue m_displayLarge;
    TypeScaleValue m_displayMedium;
    TypeScaleValue m_displaySmall;
    TypeScaleValue m_headlineLarge;
    TypeScaleValue m_headlineMedium;
    TypeScaleValue m_headlineSmall;
    TypeScaleValue m_titleLarge;
    TypeScaleValue m_titleMedium;
    TypeScaleValue m_titleSmall;
    TypeScaleValue m_bodyLarge;
    TypeScaleValue m_bodyMedium;
    TypeScaleValue m_bodySmall;
    TypeScaleValue m_labelLarge;
    TypeScaleValue m_labelMedium;
    TypeScaleValue m_labelSmall;
};

/*!
    \brief Material Design 3 emphasized type scale tokens.

    Provides access to Material Design 3 emphasized type scale definitions that can be used from
   QML.

    \code{.qml}
    import QtQuick
    import Fluid as MD

    Text {
        text: "Hello, World!"
        font.pixelSize: MD.Tokens.emphasizedTypeScale.bodyLarge.fontSize
        lineHeight: MD.Tokens.emphasizedTypeScale.bodyLarge.lineHeight
    }
    \endcode

    For more information see the
    <a href="https://m3.material.io/styles/typography/type-scale-tokens">Material Design 3
   typography guidelines</a>.
*/
class EmphasizedTypeScale : public TypeScale
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
    explicit EmphasizedTypeScale(QObject *parent = nullptr);
};

} // namespace Fluid