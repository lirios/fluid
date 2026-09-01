// SPDX-FileCopyrightText: 2026 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-License-Identifier: MPL-2.0

import QtQuick
import QtTest
import Fluid as MD

Item {
    width: 320
    height: 240

    TestCase {
        name: "SystemTokenTests"

        function verifyValues(token, expected) {
            for (const propertyName in expected)
                compare(token[propertyName], expected[propertyName], propertyName);
        }

        function propertyValue(token, propertyName) {
            return token[propertyName];
        }

        function verifyShape(actual, topLeft, topRight, bottomRight, bottomLeft, name) {
            compare(actual.topLeft, topLeft, name + ".topLeft");
            compare(actual.topRight, topRight, name + ".topRight");
            compare(actual.bottomRight, bottomRight, name + ".bottomRight");
            compare(actual.bottomLeft, bottomLeft, name + ".bottomLeft");
        }

        function verifyEasing(actual, expected, name) {
            compare(actual.x1, expected[0], name + ".x1");
            compare(actual.y1, expected[1], name + ".y1");
            compare(actual.x2, expected[2], name + ".x2");
            compare(actual.y2, expected[3], name + ".y2");
        }

        function test_shape() {
            const shape = MD.Tokens.shape;
            verifyValues(shape, {
                cornerValueExtraExtraLarge: 48,
                cornerValueExtraLarge: 28,
                cornerValueExtraLargeIncreased: 32,
                cornerValueExtraSmall: 4,
                cornerValueFull: 9999,
                cornerValueLarge: 16,
                cornerValueLargeIncreased: 20,
                cornerValueMedium: 12,
                cornerValueNone: 0,
                cornerValueSmall: 8
            });
            verifyShape(propertyValue(shape, "cornerExtraExtraLarge"), 48, 48, 48, 48,
                        "cornerExtraExtraLarge");
            verifyShape(propertyValue(shape, "cornerExtraLarge"), 28, 28, 28, 28,
                        "cornerExtraLarge");
            verifyShape(propertyValue(shape, "cornerExtraLargeIncreased"), 32, 32, 32, 32,
                        "cornerExtraLargeIncreased");
            verifyShape(propertyValue(shape, "cornerExtraLargeTop"), 28, 28, 0, 0,
                        "cornerExtraLargeTop");
            verifyShape(propertyValue(shape, "cornerExtraSmall"), 4, 4, 4, 4,
                        "cornerExtraSmall");
            verifyShape(propertyValue(shape, "cornerExtraSmallTop"), 4, 4, 0, 0,
                        "cornerExtraSmallTop");
            verifyShape(propertyValue(shape, "cornerFull"), 9999, 9999, 9999, 9999,
                        "cornerFull");
            verifyShape(propertyValue(shape, "cornerLarge"), 16, 16, 16, 16,
                        "cornerLarge");
            verifyShape(propertyValue(shape, "cornerLargeEnd"), 0, 16, 16, 0,
                        "cornerLargeEnd");
            verifyShape(propertyValue(shape, "cornerLargeIncreased"), 20, 20, 20, 20,
                        "cornerLargeIncreased");
            verifyShape(propertyValue(shape, "cornerLargeStart"), 16, 0, 0, 16,
                        "cornerLargeStart");
            verifyShape(propertyValue(shape, "cornerLargeTop"), 16, 16, 0, 0,
                        "cornerLargeTop");
            verifyShape(propertyValue(shape, "cornerMedium"), 12, 12, 12, 12,
                        "cornerMedium");
            verifyShape(propertyValue(shape, "cornerNone"), 0, 0, 0, 0, "cornerNone");
            verifyShape(propertyValue(shape, "cornerSmall"), 8, 8, 8, 8, "cornerSmall");
        }

        function test_elevation() {
            verifyValues(MD.Tokens.elevation, {
                level0: 0,
                level1: 1,
                level2: 3,
                level3: 6,
                level4: 8,
                level5: 12
            });
        }

        function test_measurement() {
            const measurement = MD.Tokens.measurement;
            const multipliers = {
                space0: 0,
                space25: 0.25,
                space50: 0.5,
                space75: 0.75,
                space100: 1,
                space125: 1.25,
                space150: 1.5,
                space175: 1.75,
                space200: 2,
                space250: 2.5,
                space300: 3,
                space400: 4,
                space450: 4.5,
                space500: 5,
                space600: 6,
                space700: 7,
                space800: 8,
                space900: 9
            };
            const expected = {
                space0: 0,
                space25: 2,
                space50: 4,
                space75: 6,
                space100: 8,
                space125: 10,
                space150: 12,
                space175: 14,
                space200: 16,
                space250: 20,
                space300: 24,
                space400: 32,
                space450: 36,
                space500: 40,
                space600: 48,
                space700: 56,
                space800: 64,
                space900: 72
            };

            verifyValues(measurement, expected);
            for (const propertyName in multipliers) {
                compare(measurement[propertyName],
                        measurement.space100 * multipliers[propertyName],
                        propertyName + " multiplier");
            }
        }

        function test_nonMaterialMeasurementPropertiesAreAbsent() {
            const unsupportedProperties = [
                "space225", "space350", "space550", "space1000"
            ];
            for (const propertyName of unsupportedProperties)
                compare(MD.Tokens.measurement[propertyName], undefined, propertyName);
        }

        function test_state() {
            verifyValues(MD.Tokens.state, {
                draggedStateLayerOpacity: 0.16,
                focusStateLayerOpacity: 0.1,
                hoverStateLayerOpacity: 0.08,
                pressedStateLayerOpacity: 0.1
            });
        }

        function test_motionDurations() {
            const duration = propertyValue(MD.Tokens.motion, "duration");
            verifyValues(duration, {
                short1: 50,
                short2: 100,
                short3: 150,
                short4: 200,
                medium1: 250,
                medium2: 300,
                medium3: 350,
                medium4: 400,
                long1: 450,
                long2: 500,
                long3: 550,
                long4: 600,
                extraLong1: 700,
                extraLong2: 800,
                extraLong3: 900,
                extraLong4: 1000
            });
        }

        function test_legacyFlatMotionDurationPropertiesAreAbsent() {
            const oldProperties = [
                "durationShort1", "durationShort2", "durationShort3", "durationShort4",
                "durationMedium1", "durationMedium2", "durationMedium3", "durationMedium4",
                "durationLong1", "durationLong2", "durationLong3", "durationLong4",
                "durationExtraLong1", "durationExtraLong2", "durationExtraLong3",
                "durationExtraLong4"
            ];
            for (const propertyName of oldProperties)
                compare(MD.Tokens.motion[propertyName], undefined, propertyName);
        }

        function test_motionEasing() {
            const easing = propertyValue(MD.Tokens.motion, "easing");
            verifyEasing(easing.emphasized, [0.2, 0, 0, 1], "emphasized");
            verifyEasing(easing.emphasizedAccelerate, [0.3, 0, 0.8, 0.15],
                         "emphasizedAccelerate");
            verifyEasing(easing.emphasizedDecelerate, [0.05, 0.7, 0.1, 1],
                         "emphasizedDecelerate");
            verifyEasing(easing.legacy, [0.4, 0, 0.2, 1], "legacy");
            verifyEasing(easing.legacyAccelerate, [0.4, 0, 1, 1],
                         "legacyAccelerate");
            verifyEasing(easing.legacyDecelerate, [0, 0, 0.2, 1],
                         "legacyDecelerate");
            verifyEasing(easing.linear, [0, 0, 1, 1], "linear");
            verifyEasing(easing.standard, [0.2, 0, 0, 1], "standard");
            verifyEasing(easing.standardAccelerate, [0.3, 0, 1, 1],
                         "standardAccelerate");
            verifyEasing(easing.standardDecelerate, [0, 0, 0, 1],
                         "standardDecelerate");
        }

        function test_motionSprings() {
            const spring = propertyValue(MD.Tokens.motion, "spring");
            const expected = {
                standardFastSpatial: [0.9, 1400],
                standardDefaultSpatial: [0.9, 700],
                standardSlowSpatial: [0.9, 300],
                standardFastEffects: [1, 3800],
                standardDefaultEffects: [1, 1600],
                standardSlowEffects: [1, 800],
                expressiveFastSpatial: [0.6, 800],
                expressiveDefaultSpatial: [0.8, 380],
                expressiveSlowSpatial: [0.8, 200],
                expressiveFastEffects: [1, 3800],
                expressiveDefaultEffects: [1, 1600],
                expressiveSlowEffects: [1, 800]
            };
            for (const propertyName in expected) {
                const value = spring[propertyName];
                compare(value.damping, expected[propertyName][0], propertyName + ".damping");
                compare(value.stiffness, expected[propertyName][1], propertyName + ".stiffness");
            }
        }

        function test_legacyFlatPropertiesAreAbsent() {
            const oldProperties = [
                "cornerRadiusNone", "cornerRadiusExtraSmall", "cornerRadiusSmall",
                "cornerRadiusMedium", "cornerRadiusLarge", "cornerRadiusLargeIncreased",
                "cornerRadiusExtraLarge", "cornerRadiusFull",
                "spacingExtraSmall", "spacingSmall", "spacingMedium", "spacingLarge",
                "spacingExtraLarge",
                "elevationLevel0", "elevationLevel1", "elevationLevel2", "elevationLevel3",
                "elevationLevel4", "elevationLevel5",
                "durationShort1", "durationShort2", "durationShort3", "durationShort4",
                "durationMedium1", "durationMedium2", "durationMedium3", "durationMedium4",
                "durationLong1", "durationLong2", "durationLong3", "durationLong4",
                "durationExtraLong1", "durationExtraLong2", "durationExtraLong3",
                "durationExtraLong4", "easing", "spring", "system"
            ];
            for (const propertyName of oldProperties)
                compare(MD.Tokens[propertyName], undefined, propertyName);
        }
    }
}
