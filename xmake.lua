target("spdlog")
    add_includedirs(
        "$(projectdir)/Vendor/spdlog/include/"
    )

     on_build("windows", function(target)
        os.cd("$(projectdir)/Vendor/spdlog")
        if (is_mode("debug"))
        then
            os.run("cmake -B build -D CMAKE_BUILD_TYPE=Debug")
            os.run("cmake --build build")
        else
            os.run("cmake -B build -D CMAKE_BUILD_TYPE=Release")
            os.run("cmake --build build --config Release")
        end
        os.cd("$(projectdir)")
    end)

    after_build("windows", function(target)
    if (is_mode("debug"))
        then
            os.cp("$(projectdir)/Vendor/spdlog/build/Debug/*.lib", "$(projectdir)/lib/")
            os.trymv("$(projectdir)/lib/spdlogd.lib", "$(projectdir)/lib/spdlog.lib")

            os.cp("$(projectdir)/Vendor/spdlog/build/Debug/*.pdb", "$(projectdir)/lib/")
            os.trymv("$(projectdir)/lib/spdlogd.pdb", "$(projectdir)/lib/spdlog.pdb")
        else
            os.cp("$(projectdir)/Vendor/spdlog/build/Release/*.lib", "$(projectdir)/lib/")
        end
    end)

    on_clean("windows", function(target)
        if os.exists("$(buildir)") then
            os.rm("$(buildir)/")
        end
    end)

    set_group("Vendor")