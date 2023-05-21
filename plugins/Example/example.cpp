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
#include <QVector>

#include "example.h"
#include <iostream>
#include <stdlib.h>
#include <vector>
#include <string.h>
#include <future> // for async calls
#include <sstream>
#include <unistd.h>

#include <thread>

#include <pstreams/pstream.h>

Example::Example()
{
}

QString appDataPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/";
//appDataPath.append("/");
QByteArray ba = appDataPath.toLocal8Bit();
char *path = ba.data();
QString output;
std::vector<std::string> args;

void Example::save(int lang, QString code)
{
    std::string file = std::string(path);
    QByteArray ba = code.toLocal8Bit();
    char *content = ba.data();

    if (lang == 0) // C
        file.append("file.c");
    else // C++
        file.append("file.cpp");

    std::FILE *fp = fopen(file.c_str(), "w");
    std::fprintf(fp, "%s", content);
    std::fclose(fp);
}

// language: C/C++  |  std: c++11, gnu98 etc.
void Example::compile(int lang, int std)
{
    std::string command;
    std::string file = std::string(path);

    if (lang == 0) { // C
        file.append("file.c");
        command = std::string("gcc ") + file + " --std c" + std::to_string(std);
    } else { // C++
        file.append("file.cpp");
        command = std::string("g++ ") + file + " --std c++" + std::to_string(std);
    }

    if (system(command.c_str()) == 0)
        qDebug() << "Compiled succesfully!";
    else
        qDebug() << "Failed to compile";
}


void run()
{
    //qDebug() << "Async started";
    output.clear();
    std::string str;
    redi::ipstream in("./a.out", args);
    //sleep(5);
    //std::string nl = std::endl;

    QString newline = QString::fromLocal8Bit("\n"); //QString::fromStdString(nl);

    while (std::getline(in, str)) {
        //std::cout << str;
        QString temp = QString::fromStdString(str);
        //qDebug() << "started to read";
        if (in.peek() != EOF) {
            //std::cout << std::endl;
            temp.append(newline);
            //qDebug() << "searching";
        }
        output.push_back(temp);
        //qDebug() << "added line";
    }
    qDebug() << "Process ended";
    args.clear();
}

void Example::runAsync(QString qargs)
{
    qDebug() << qargs;
    std::string temp = qargs.toStdString();
    args.push_back(temp);
    //qDebug() << "Starting Async";
    std::thread t(run);
    t.detach();
    //qDebug() << "Async is running";
}

QString Example::getOutput()
{
    //return QString::fromStdString(output);
    return output;
}
/*
void Example::sendInput()
{
    in.write()
}*/
