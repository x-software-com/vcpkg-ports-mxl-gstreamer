vcpkg_from_gitlab(
    GITLAB_URL https://gitlab.com
    OUT_SOURCE_PATH SOURCE_PATH
    REPO AOMediaCodec/SVT-AV1
    REF "v${VERSION}"
    SHA512 4301e923965e3bff30a0fd2f74ae023d19260f91c2361d48ea7bc1718f501dcca73fa17cb8795b23392ca1bfbe1f4d55edcbb5ce06a2fa9e41da36c5166f527d
    HEAD_REF master
    PATCHES
        ${PATCHES}
)

vcpkg_find_acquire_program(FLEX)
vcpkg_find_acquire_program(BISON)
vcpkg_find_acquire_program(NASM)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_APPS=OFF
    ADDITIONAL_BINARIES
        flex='${FLEX}'
        bison='${BISON}'
        nasm='${NASM}'
)
vcpkg_cmake_install()
vcpkg_copy_pdbs()

# Remove duplicated folders in debug directory
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/tools"
)

vcpkg_fixup_pkgconfig()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md" "${SOURCE_PATH}/PATENTS.md")
