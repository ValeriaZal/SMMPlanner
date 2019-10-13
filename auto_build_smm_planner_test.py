import os
import subprocess
import sys
import shutil
import urllib.request
import urllib.error
import zipfile

github_link = "https://github.com/ValeriaZal/SMMPlanner"
location_src = os.path.normpath("../Src_x64")
location_release_src = os.path.normpath("../Release_Src_x64")
location_release = os.path.normpath("../Output")
location_exe = location_release
location_workpath = os.path.normpath("../Release_x64/build")
location_spec = location_release
folder_name = "SMM_Planner"

# to allow the script to be run from anywhere - not just the cwd - store the absolute path to the script file
script_root = os.path.dirname(os.path.realpath(__file__))


def download_and_unzip(key, value):
    tmp_path = os.path.join(script_root, "", value)
    target_path = os.path.normpath(tmp_path)

    if os.path.isdir(target_path) is False:
        os.makedirs(target_path)

    zip_filename = key.split('/')[-1].split('#')[0].split('?')[0]
    zip_path = os.path.join(target_path, zip_filename)

    if os.path.isfile(zip_path) is False:
        print("\nDownloading " + key + " into " + zip_path)
        try:
            urllib.request.urlretrieve(key, zip_path)
        except urllib.error.HTTPError:
            print("Error: HTTP Error 404: Not Found.\nPlease, check your parameters")
            sys.exit(1)

        print("\nUnzipping " + key + " into " + zip_path)
        if os.path.splitext(zip_path)[1] == ".zip":
            zipfile.ZipFile(zip_path).extractall(target_path)
            os.remove(zip_path)


def install_app():
    # pyinstaller
    commandArgs = [" --noconsole",
                   " --distpath " + location_release,
                   " --workpath " + location_workpath,
                   " --name " + folder_name,
                   " --specpath " + location_spec,
                   " --log-level=TRACE"]
    if len(sys.argv) >= 4:
        commandArgs.append(" --icon " + sys.argv[3])

    script_path = os.path.join(script_root, "", location_src + "/SMMPlanner-config_test/SMMP_test_config/project_src")
    script_fill_path = os.path.normpath(script_path + "/app.py")
    commandArgs.append(" " + script_fill_path)

    p = subprocess.Popen(["pyinstaller", commandArgs])
    p.wait()

    print("Copying qml files")
    dst_folder = os.path.normpath(location_release + "/" + folder_name)
    for root, dirs, files in os.walk(script_path):
        for file_ in files:
            if file_.endswith("qml"):
                shutil.copy(os.path.join(root, file_), os.path.join(dst_folder, file_))


# argv:
# [0] script_name,
# [1] src/release/exe,
# [2] branch/version <master or v1.2>
# [3] <optional> icon_file
if __name__ == "__main__":
    print("usage: auto_build_smm_planner.py [src/release] [branch(for src)/version(for release)]")

    build_from = ""
    if len(sys.argv) < 3:
        print("Warning: lack of arguments. SMM Planner will build from source code from config_test branch")
        build_from = "src"
        branch_or_version = "config_test"
    else:
        build_from = sys.argv[1]
        branch_or_version = sys.argv[2]

    if build_from == "src":
        github_src_full_link = github_link + "/archive/" + branch_or_version + ".zip"
        download_and_unzip(github_src_full_link, location_src)
        install_app()
    elif build_from == "release":
        github_release_src_link = github_link + "/archive/" + branch_or_version + ".zip"
        location_release_src += "/" + branch_or_version + "/"
        download_and_unzip(github_release_src_link, location_release_src)
        install_app()
    elif build_from == "exe":
        github_release_src_link = github_link + "/releases/download/" \
                                  + branch_or_version + "/SMM_Planner_" + branch_or_version + ".zip"
        download_and_unzip(github_release_src_link, location_exe)
    else:
        print("Error: one or more arguments do not correct")
        sys.exit(1)

    print("Done")
