#!/usr/bin/python3
"""
This script defines a Fabric function to generate a .tgz archive from the
web_static folder for deployment. The archive is stored inside the 'versions'
directory with a timestamped filename.
"""

from fabric.api import local
from datetime import datetime
import os

def do_pack():
    """
    Generates a .tgz archive from the contents of the web_static folder.
    The archive is stored in the versions/ directory and named using the
    current timestamp (format: web_static_YYYYMMDDHHMMSS.tgz).

    Returns:
        The path to the created archive if successful, otherwise None.
    """
    if not os.path.isdir("versions"):
        os.mkdir("versions")
    now = datetime.now().strftime("%Y%m%d%H%M%S")
    file_path = f"versions/web_static_{now}.tgz"
    result = local(f"tar -cvzf {file_path} web_static")
    if result.failed:
        return None
    return file_path

