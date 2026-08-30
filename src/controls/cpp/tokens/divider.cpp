// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

#include "divider.h"

// Values map to AndroidX Material 3 DividerTokens.kt in the pinned token set:
// https://android.googlesource.com/platform/frameworks/support/+/5ba2cdd61be7b6945db999b238d14f3c626136fb/compose/material3/material3/src/commonMain/kotlin/androidx/compose/material3/tokens/

namespace Fluid {

qreal Divider::thickness() const
{
    return 1.0;
}

qreal Divider::inset() const
{
    return 16.0;
}

} // namespace Fluid
