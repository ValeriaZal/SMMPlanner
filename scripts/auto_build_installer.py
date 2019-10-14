import os
import subprocess
import shutil
import zipfile

location_src_output = os.path.normpath("../Output")
location_dst_data = os.path.normpath("../installer/packages/SMM_Planner/data")

# <location-of-ifw>\binarycreator.exe
# -p <package_directory = ../Output>
# -c <config_directory = ../installer>\<config_file=config.xml>
# <installer_name = SMM Planner Installer>

if __name__ == "__main__":
    print("\nCopying data files from Output")
    shutil.rmtree(location_dst_data, ignore_errors=True)
    shutil.copytree(location_src_output, location_dst_data)

    print("\nBuilding installer")
    commandArgs = [" --offline-only",
                   " -c ..\installer\config\config.xml",
                   " -p ..\installer\packages",
                   " ..\Output\SMM_Planner_Installer_test.exe"]
    p = subprocess.Popen(["binarycreator.exe", commandArgs])
    p.wait()
    print("\nDone")
