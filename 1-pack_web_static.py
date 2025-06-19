#!/usr/bin/python3
"""
Generates a .tgz archive from the contents of web_static
"""
from fabric.api import local
from datetime import datetime
import os

def do_pack():
    """Create .tgz archive from web_static"""
    if not os.path.isdir("versions"):
        os.mkdir("versions")
    now = datetime.now().strftime("%Y%m%d%H%M%S")
    file_path = f"versions/web_static_{now}.tgz"
    result = local(f"tar -cvzf {file_path} web_static")
    if result.failed:
        return None
    return file_path
