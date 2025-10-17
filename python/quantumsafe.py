import subprocess
import json
import os

# Path to your quantum-safe EXE
EXE_PATH = os.path.join(os.path.dirname(__file__), "pqc_server.exe")

def _run_command(command, data=None):
    """Helper to communicate with the EXE."""
    try:
        cmd = [EXE_PATH, command]
        if data:
            cmd.append(json.dumps(data))
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=10)
        if result.returncode != 0:
            raise RuntimeError(result.stderr)
        return json.loads(result.stdout)
    except Exception as e:
        raise RuntimeError(f"QuantumSafe command failed: {e}")

def generate_keypair():
    return _run_command("generate_keypair")

def encrypt(public_key, message: bytes):
    data = {
        "public_key": public_key,
        "message": message.decode() if isinstance(message, bytes) else message
    }
    return _run_command("encrypt", data)["ciphertext"].encode()

def decrypt(private_key, ciphertext: bytes):
    data = {
        "private_key": private_key,
        "ciphertext": ciphertext.decode() if isinstance(ciphertext, bytes) else ciphertext
    }
    return _run_command("decrypt", data)["plaintext"].encode()
