# -*- coding: utf-8 -*-

import os
import shlex
from subprocess import call
from watchgod import watch

BASE_DIR = os.path.abspath(os.path.dirname(__file__))
SOURCE_DIR_NAME = "source"
SOURCE_DIR = os.path.join(BASE_DIR, SOURCE_DIR_NAME)

print("Watching for changes on '%s%s' directory..." % (
    SOURCE_DIR_NAME, os.sep))

def main():
    RUNNING = False
    for changes in watch(SOURCE_DIR):
        if not RUNNING:
            RUNNING = True
            call(shlex.split("make html"))
            RUNNING = False

if __name__ == "__main__":
    main()
