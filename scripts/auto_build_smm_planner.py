import os
import subprocess
import sys
import shutil
import urllib.request
import urllib.error
import zipfile

github_link = "https://github.com/ValeriaZal/SMMPlanner"
location_code_src = os.path.normpath("../Src_x64")
location_release_src = os.path.normpath("../Release_Src_x64")
location_release = os.path.normpath("../Output")
location_workpath = os.path.normpath("../supplement")
location_spec = location_release
folder_name = "SMM_Planner"
#pyqt5_qt_folder_name = os.path.normpath("C:\Program Files\Python37\Lib\site-packages\PyQt5\Qt")
pyqt5_qt_folder_name = os.path.normpath("/modules/PyQt5/Qt")

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


def install_app(location_src):
    # pyinstaller
    commandArgs = [" --noconsole  --noconfirm",
                   " --distpath " + location_release,
                   " --workpath " + location_workpath,
                   " --name " + folder_name,
                   " --specpath " + location_spec,
                   " --log-level=TRACE"]
    if len(sys.argv) >= 4:
        commandArgs.append(" --icon " + sys.argv[3])

    main_path = os.path.join(script_root, "", location_src)
    main_fill_path = os.path.normpath(main_path + "/main.py")
    commandArgs.append(" " + main_fill_path)

    p = subprocess.Popen(["pyinstaller", commandArgs])
    p.wait()

    copy_data(location_src)


def copy_data(location_src):
    main_path = os.path.join(script_root, "", location_src)

    print("Copying qml files:")
    dst_folder = os.path.normpath(location_release + "/" + folder_name + "/ui")
    if not os.path.exists(dst_folder):
        os.mkdir(dst_folder)
    for root, dirs, files in os.walk(os.path.normpath(main_path + "/ui/")):
        for file_ in files:
            if file_.endswith("qml"):
                print("Copying", file_, "from", root, "to", dst_folder)
                shutil.copy(os.path.join(root, file_), os.path.join(dst_folder, file_))

    print("Copying icons files:")
    dst_folder = os.path.normpath(location_release + "/" + folder_name + "/icons")
    if not os.path.exists(dst_folder):
        os.mkdir(dst_folder)
    for root, dirs, files in os.walk(os.path.normpath(main_path + "/icons/")):
        for file_ in files:
            print("Copying", file_, "from", root, "to", dst_folder)
            shutil.copy(os.path.join(root, file_), os.path.join(dst_folder, file_))
            
    pyqt5_add_folder = os.path.join(main_path + pyqt5_qt_folder_name)

    print("Copying PyQtWebEngine files:")
    print("Copying PyQtWebEngine bin files:")
    src_folder = os.path.normpath(pyqt5_add_folder + "/bin")
    dst_folder = os.path.normpath(location_release + "/" + folder_name + "/PyQt5/Qt/bin")
    shutil.rmtree(dst_folder)
    shutil.copytree(src_folder, dst_folder, ignore=None)
    
    print("Copying PyQtWebEngine resources files:")
    src_folder = os.path.normpath(pyqt5_add_folder + "/resources")
    dst_folder = os.path.normpath(location_release + "/" + folder_name + "/PyQt5/Qt/resources")
    shutil.rmtree(dst_folder)
    shutil.copytree(src_folder, dst_folder, ignore=None)

    print("Copying PyQtWebEngine translations files:")
    src_folder = os.path.normpath(pyqt5_add_folder + "/translations")
    dst_folder = os.path.normpath(location_release + "/" + folder_name + "/PyQt5/Qt/translations")
    shutil.rmtree(dst_folder)
    shutil.copytree(src_folder, dst_folder, ignore=None)

    print("Copying PyQtWebEngine plugins files:")
    src_folder = os.path.normpath(pyqt5_add_folder + "/plugins")
    dst_folder = os.path.normpath(location_release + "/" + folder_name + "/PyQt5/Qt/plugins")
    shutil.rmtree(dst_folder)
    shutil.copytree(src_folder, dst_folder, ignore=None)
    
    #print("Copying modules files:")
    #dst_folder = os.path.normpath(location_release + "/" + folder_name + "/modules")
    #if not os.path.exists(dst_folder):
    #    os.mkdir(dst_folder)
    #for root, dirs, files in os.walk(os.path.normpath(main_path + "/modules/")):
    #    for file_ in files:
    #        print("Copying", file_, "from", root, "to", dst_folder)
    #        shutil.copy(os.path.join(root, file_), os.path.join(dst_folder, file_))





# argv:
# [0] script_name,
# [1] src/release/exe,
# [2] branch/version <master or v1.2>
# [3] <optional> icon_file
if __name__ == "__main__":
    print("usage: auto_build_smm_planner.py [src/release/exe] [branch(for src)/version(for release and exe)]")

    build_from = ""
    if len(sys.argv) < 3:
        build_from = "src"
        branch_or_version = "master"
        print("Warning: lack of arguments. SMM Planner will build from source code from branch:", branch_or_version)
    else:
        build_from = sys.argv[1]
        branch_or_version = sys.argv[2]

    if build_from == "src":
        github_src_full_link = github_link + "/archive/" + branch_or_version + ".zip"
        download_and_unzip(github_src_full_link, location_code_src)
        install_app(location_code_src + "/SMMPlanner-" + branch_or_version + "/src")
    elif build_from == "release":
        github_release_src_link = github_link + "/archive/" + branch_or_version + ".zip"
        location_release_src += "/" + branch_or_version + "/"
        download_and_unzip(github_release_src_link, location_release_src)
        install_app(location_release_src + "SMMPlanner-" + branch_or_version[1:] + "/src")
    elif build_from == "exe":
        github_release_src_link = github_link + "/releases/download/" \
                                + branch_or_version + "/SMM_Planner_" + branch_or_version + ".zip"
    else:
        print("Error: one or more arguments do not correct")
        sys.exit(1)

    print("Done")
