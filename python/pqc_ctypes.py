import subprocess
import sys
from pathlib import Path

_here = Path(__file__).parent
EXE = _here / "pqc_server.exe"

def start_server(args=None):
    if args is None:
        args = []
    # Run the server exe and wait
    try:
        subprocess.run([str(EXE), *args], check=True)
    except Exception as e:
        print("Failed to run server:", e, file=sys.stderr)
