#!/usr/bin/env python
"""Django's command-line utility for administrative tasks."""
import os
import sys

import django
import uvicorn

from utils.log import Loggers


def main():
    """Run administrative tasks."""
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'fuadmin.settings')
    django.setup()
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    if  sys.argv[1] == 'runserver' :
        port = int(sys.argv[2]) if sys.argv[2] else 8000
        config = uvicorn.Config('fuadmin.asgi:application', host="0.0.0.0", reload=True, port=port)
        server = uvicorn.Server(config)
        Loggers.init_config()
        server.run()
    else:
        execute_from_command_line(sys.argv)
    execute_from_command_line(sys.argv)


if __name__ == '__main__':
    main()
