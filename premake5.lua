workspace "GLFWGL"

    configurations {"Debug", "Release"}
    platforms {"x64_development", "x64_deploy"}
    location("workspace")
    -- compiler/linker flags
    flags {"C++14", "MultiProcessorCompile", "NoImplicitLink", "NoMinimalRebuild"}
    -- library/include paths
    libdirs{"dependencies/lib"}
    includedirs{"dependencies/include", "src"}
    -- platform settings
    filter {"platforms:x64*"}
        architecture "x64"
    filter {"platforms:x64_development"}
        defines {"DEVELOPMENT"}
    filter{}

    -----------------------------------------------------
    project "runtime"
        kind "ConsoleApp"    
        language "C++"
        targetdir "bin/%{cfg.buildcfg}"
        location("workspace/runtime")
        files {"src/runtime/**.h", "src/runtime/**.cpp", "src/runtime/**.c"}
        -- disable unity builds for now
        --filter {"files:**.cpp or **.c"}
        --    flags {"ExcludeFromBuild"}
        --filter {"files:runtime/unitybuild.cpp"}
        --    removeflags {"ExcludeFromBuild"}

        links{"glfw3"}
        filter { "system:windows" }
		    links { "OpenGL32" }
	    filter { "system:not windows" }
		    links { "GL" }

        filter "configurations:Debug"
            defines {"GT_DEBUG"}
            symbols "On"
       filter "configurations:Release"
            defines {"GT_NODEBUG"}
            optimize "On"

   
