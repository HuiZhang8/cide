/*
 * Copyright (C) 2023  ikozyris
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * cide is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Lomiri.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import Example 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'cide.ikozyris'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('C IDE')
            trailingActionBar {
                actions: [
                    Action {
                        iconName: "send"
                        text: i18n.tr("Run")
                        onTriggered: {
                            Example.run();
                        }
                    },
                    Action {
                        iconName: "settings"
                        text: i18n.tr("Compile")
                        onTriggered: {
                            Example.compile();
                        }
                    },
                    Action {
                        iconName: "document-save"
                        text: i18n.tr("Save")
                        onTriggered: {
                            Example.save(code.text);
                        }
                    }
                ]
            }
        }

        TextArea {
            id: code
            anchors {
                top: header.bottom
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }
            placeholderText: "Enter Code"
        }
    }
}
