# Objective C Demo

this started as a copy of https://github.com/Microsoft/WinObjC/tree/develop/samples/HelloOpenGL.

I'm editing and building from vscode to avoid false errors from using clang extensions.

And, I've removed the NugetRestore node from the solution explorer because 
msbuild is not compatible with nugetrestore... 


### debug 
    $repopath = "."
    $devenv = "/Program Files (x86)/Microsoft Visual Studio/2017/Community/Common7/IDE/devenv"
    $sln = (gci -Path $repopath -recurse -include HelloOpenGL-WinStore10.sln).fullname
    $params = "/runexit"
    & $devenv $sln $params

### build
    $repopath = "."
    $msbuild = "/Program Files (x86)/Microsoft Visual Studio/2017/Community/MSBuild/15.0/Bin/MSBuild.exe"
    $sln = (gci -Path $repopath -recurse -include HelloOpenGL-WinStore10.sln).fullname
    $params = "/p:Configuration=Debug /p:Platform=Win32" 
    & $msbuild $sln $params

### deploy
    "/Program Files (x86)/Microsoft Visual Studio/2017/Community/Common7/IDE/devenv" "c:/Users/darko/Documents/GitHub/WinObjC/samples/HelloOpenGL2/HelloOpenGL-WinStore10.sln" /clean

    "/Program Files (x86)/Microsoft Visual Studio/2017/Community/Common7/IDE/devenv" /deploy debug "c:/Users/darko/Documents/GitHub/WinObjC/samples/HelloOpenGL2/HelloOpenGL-WinStore10.sln"


## isues
deploy is not working from msbuild. seems to be a problem for many:
https://github.com/Microsoft/msbuild/issues/1901


