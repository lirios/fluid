// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include "segmentedbutton.h"

namespace Fluid {

TypeScaleValue SegmentedButton::labelTextFont() const
{
    static const TypeScaleValue value = TypeScale{ }.labelLarge();
    return value;
}

} // namespace Fluid
