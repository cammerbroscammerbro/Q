from setuptools import setup

setup(
    name="quantumsafe",
    version="0.1",
    py_modules=["quantumsafe"],
    include_package_data=True,
    package_data={"": ["pqc_server.exe"]},
    description="Quantum-safe encryption library wrapping pqc_server.exe",
)
