# Objective C Demo

this started as a copy of https://github.com/Microsoft/WinObjC/tree/develop/samples/HelloOpenGL.

I'm editing and building from vscode to avoid false errors from using clang extensions. It's also much faster to use. Builds are way faster, so is loading the ide.

To debug or reconfigure the project, use VisualStudio.

And, I've removed the NugetRestore node from the solution explorer because 
msbuild is not compatible with nugetrestore... I may revert this - I've switched to using devenv for builds.

### debug 
    "/Program Files (x86)/Microsoft Visual Studio/2017/Community/Common7/IDE/devenv" "c:/Users/darko/Documents/GitHub/WinObjC/samples/HelloOpenGL2/HelloOpenGL-WinStore10.sln" /runexit

### build
    "/Program Files (x86)/Microsoft Visual Studio/2017/Community/Common7/IDE/devenv" "c:/Users/darko/Documents/GitHub/WinObjC/samples/HelloOpenGL2/HelloOpenGL-WinStore10.sln" /build

### clean
    "/Program Files (x86)/Microsoft Visual Studio/2017/Community/Common7/IDE/devenv" "c:/Users/darko/Documents/GitHub/WinObjC/samples/HelloOpenGL2/HelloOpenGL-WinStore10.sln" /clean

### deploy
    "/Program Files (x86)/Microsoft Visual Studio/2017/Community/Common7/IDE/devenv"  "c:/Users/darko/Documents/GitHub/WinObjC/samples/HelloOpenGL2/HelloOpenGL-WinStore10.sln" /deploy




## isues
deploy is not working from msbuild. seems to be a problem for many:
https://github.com/Microsoft/msbuild/issues/1901


