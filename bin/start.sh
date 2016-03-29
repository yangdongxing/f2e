#!/bin/bash

nohup hugo server -b http://f2e.dxy.net/blog --appendPort=false --buildDrafts --watch

nohup hook/publish.js
