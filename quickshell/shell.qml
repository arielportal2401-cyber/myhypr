pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Widgets

ShellRoot {
    id: root

    readonly property color background: "#e6111318"
    readonly property color surface: "#ff202124"
    readonly property color foreground: "#ffe3e2e6"
    readonly property color muted: "#ff9aa0aa"
    readonly property color accent: "#ff89b4fa"

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData
            color: "transparent"
            implicitHeight: 38
            exclusiveZone: 38

            anchors {
                top: true
                left: true
                right: true
            }

            Rectangle {
                anchors.fill: parent
                color: root.background

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    spacing: 8

                    Rectangle {
                        implicitWidth: 28
                        implicitHeight: 28
                        radius: 7
                        color: launcherMouse.containsMouse ? root.accent : root.surface

                        Text {
                            anchors.centerIn: parent
                            text: "◆"
                            color: launcherMouse.containsMouse ? root.surface : root.accent
                            font.pixelSize: 14
                        }

                        MouseArea {
                            id: launcherMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Quickshell.execDetached(["fuzzel"])
                        }
                    }

                    Repeater {
                        model: 5

                        Rectangle {
                            required property int index
                            readonly property int workspace: index + 1
                            readonly property bool active: Hyprland.focusedWorkspace?.id === workspace

                            implicitWidth: 28
                            implicitHeight: 28
                            radius: 7
                            color: active ? root.accent : workspaceMouse.containsMouse ? "#ff34373d" : "transparent"

                            Text {
                                anchors.centerIn: parent
                                text: parent.workspace
                                color: parent.active ? root.surface : root.foreground
                                font.pixelSize: 13
                                font.weight: parent.active ? Font.DemiBold : Font.Normal
                            }

                            MouseArea {
                                id: workspaceMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: Hyprland.dispatch("workspace " + parent.workspace)
                            }
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        Layout.leftMargin: 8
                        text: Hyprland.activeToplevel?.title || "Desktop"
                        color: root.muted
                        elide: Text.ElideRight
                        font.pixelSize: 13
                    }

                    Repeater {
                        model: SystemTray.items

                        MouseArea {
                            required property SystemTrayItem modelData

                            implicitWidth: 24
                            implicitHeight: 24
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            cursorShape: Qt.PointingHandCursor
                            onClicked: event => {
                                if (event.button === Qt.LeftButton)
                                    modelData.activate();
                                else
                                    modelData.secondaryActivate();
                            }

                            IconImage {
                                anchors.centerIn: parent
                                implicitSize: 17
                                source: parent.modelData.icon
                            }
                        }
                    }

                    Text {
                        text: Qt.formatDateTime(clock.date, "ddd  dd MMM  HH:mm")
                        color: root.foreground
                        font.pixelSize: 13
                        font.weight: Font.Medium
                    }
                }
            }
        }
    }
}
