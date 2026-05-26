#!/bin/bash
DIRS=(
    "$HOME/.cache/thumbnails"
    "$HOME/.cache/net.imput.helium"
    "$HOME/.cache/mesa_shader_cache"
    "$HOME/.cache/mesa_shader_cache_sf"
    "$HOME/.cache/radv_builtin_shaders"
    "$HOME/.cache/go-build"
    "$HOME/.cache/cliphist"
    "$HOME/.cache/gstreamer-1.0"
    "$HOME/.cache/caelestia"
    "$HOME/.cache/protonfixes"
    "$HOME/.cache/cirno"
    "$HOME/.cache/fontconfig"
    "$HOME/.cache/gitstatus"
    "$HOME/.cache/fish"
    "$HOME/.cache/qtshadercache-x86_64-little_endian-lp64"
    "$HOME/.cache/gtk-4.0"
    "$HOME/.cache/debuginfod_client"
    "$HOME/.cache/pip"
    "$HOME/.cache/typescript"
    "$HOME/.cache/mpv"
    "$HOME/.cache/quickshell"
    "$HOME/.cache/paru/clone"
    "$HOME/.config/net.imput.helium/Cache"
    "$HOME/.config/net.imput.helium/Code Cache"
    "$HOME/.config/net.imput.helium/GPUCache"
    "$HOME/.config/net.imput.helium/Default/Service Worker/CacheStorage"
    "$HOME/.config/net.imput.helium/Default/File System"
    "$HOME/.config/discord/Cache"
    "$HOME/.config/discord/Code Cache"
    "$HOME/.config/discord/GPUCache"
    "$HOME/.config/VSCodium/Cache"
    "$HOME/.config/VSCodium/GPUCache"
    "$HOME/.config/VSCodium/CachedExtensionVSIXs"
    "$HOME/.config/VSCodium/CachedData"
    "$HOME/.config/VSCodium/DawnWebGPUCache"
)
measure() {
    du -sbc \
        "$HOME/.cache" \
        "$HOME/.config/discord" \
        "$HOME/.config/net.imput.helium" \
        "$HOME/.config/VSCodium" \
        2>/dev/null \
        | tail -1 \
        | awk '{
            size = $1
            if (size >= 1073741824) printf "%.2f GB", size/1073741824
            else printf "%.2f MB", size/1048576
        }'
}
before=$(measure)
notify-send "Cache Cleaner" "Starting cleanup..." -u low
for dir in "${DIRS[@]}"; do
    if [ -d "$dir" ]; then
        find "$dir" -type f -delete
        find "$dir" -mindepth 1 -type d -empty -delete
    fi
done
after=$(measure)
notify-send "Cache Cleaner" "Done ✔\nBefore: $before\nAfter: $after" -u normal
