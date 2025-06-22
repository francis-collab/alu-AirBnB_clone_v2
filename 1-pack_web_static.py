#!/usr/bin/python3
"""
Generates a .tgz archive from web_static and stores it in versions/.
"""

from fabric.api import local
from datetime import datetime


def do_pack():
    """
    Creates a .tgz archive from the contents of the web_static folder,
    names it using the current timestamp, and stores it inside versions/.

    Returns:
        The archive path if successful, None otherwise.
    """
    local("mkdir -p versions")
    now = datetime.now().strftime("%Y%m%d%H%M%S")
    file_path = f"versions/web_static_{now}.tgz"
    result = local(f"tar -cvzf {file_path} web_static")
    return file_path if result.succeeded else None
