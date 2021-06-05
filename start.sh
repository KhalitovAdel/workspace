#!/usr/bin/env bash

CUID="$(id -u)" CGID="$(id -g)" docker-compose up -d --build
