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

#include <QDebug>
#include <QStandardPaths>
#include <QString>

#include "example.h"
#include <iostream>
#include <stdlib.h>
#include <stdlib.h>
#include <string.h>

Example::Example() {

}

std::string path = "/home/user/cide/build/x86_64-linux-gnu/app/install/";
std::string file = std::string(path) + "file.c";

void Example::save(QString code) {
    QString appDataPath = code;
    QByteArray ba = appDataPath.toLocal8Bit();
    char *content = ba.data();

    std::FILE *fp = fopen(file.c_str(), "w");
    std::fprintf(fp,content);
    std::fclose(fp);
}
void Example::compile() {

    //QString appDataPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    //QByteArray ba = appDataPath.toLocal8Bit();
    //char *path = ba.data();
    std::string command = std::string("gcc ") + file + " -O2"; 
    std::system(command.c_str());
}

void Example::run() {
    std::system("./a.out");
}
