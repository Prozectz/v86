# Download ALL v86 disk images from i.copy.sh
# This script attempts to download every image referenced in src/browser/main.js

$images = @(
    # Linux ISOs
    "linux.iso",
    "linux3.iso",
    "linux4.iso",
    "TinyCore-11.0.iso",
    
    # State files
    "arch_state-v3.bin.zst",
    "arch_state-v2.bin.zst",
    "serenity_state-v4.bin.zst",
    "redox_state-v2.bin.zst",
    "haiku_state-v5.bin.zst",
    "windows2k_state-v4.bin.zst",
    "windows-me_state-v2.bin.zst",
    "windows98_state-v2.bin.zst",
    "freebsd_state-v2.bin.zst",
    "reactos_state-v3.bin.zst",
    "9front_state-v3.bin.zst",
    "openbsd_state-v2.bin.zst",
    
    # DOS and Early Windows
    "freedos722.img",
    "msdos.img",
    "msdos622.img",
    "msdos4.img",
    "windows101.img",
    "windows2.img",
    "win31.img",
    "Win30.iso",
    
    # Small OSes and demos
    "buildroot-bzimage68.bin",
    "buildroot-bzimage.bin",
    "openbsd-floppy.img",
    "kolibri.img",
    "oberon.img",
    "mobius-fd-release5.img",
    "os8.img",
    
    # Boot sector demos and games
    "bootchess.img",
    "bootbasic.img",
    "bootlogo.img",
    "bootdino.img",
    "bootrogue.img",
    "pillman.img",
    "invaders.img",
    "floppybird.img",
    "stillalive-os.img",
    "hello-v86.img",
    "tetros.img",
    "sectorlisp-friendly.bin",
    "sectorforth.img",
    "duskos.img",
    
    # Other OSes
    "HelenOS-0.14.1-ia32.iso",
    "sortix-1.0-i686.iso",
    "skift-20200910.iso",
    "snowdrop.img",
    "openwrt-18.06.1-x86-legacy-combined-squashfs.img",
    "qnx-demo-network-4.05.img",
    "9legacy.img",
    
    # Misc
    "xcom144.img",
    "mu-shell.img",
    "crazierl-elf.img",
    "crazierl-initrd.img",
    "bl3-5.img",
    "xpud-0.9.2.iso",
    "elks-hd32-fat.img",
    "nodeos-kernel.bin",
    "dsl-4.11.rc2.iso",
    "xwoaf_rebuild4.iso",
    "tilck.img",
    "littlekernel-multiboot.img",
    "sanos-flp.img",
    "pc86dos.img",
    
    # Additional images found in main.js
    "slitaz-rolling-2024.iso",
    "toaruos-1.6.1-core.iso",
    "FreeNOS-1.0.3.iso",
    "soso.iso",
    "nanoshell.iso",
    "prettyos.img",
    "mikeos.iso",
    "newos-flp.img",
    "SqueakNOS.iso",
    "vanadiumos.iso",
    "os64boot.iso",
    "nopeos-0.1.iso",
    "leetos.img",
    "curios.img",
    "mojo-0.2.2.iso",
    "BoneOS.iso",
    "asuro.iso",
    "catkernel.iso",
    "dancy.iso",
    "ipxe.iso",
    "netboot.xyz.iso",
    "jx-demo.img",
    "mcp2.img",
    "xenushdd.img",
    "t3xforth.img",
    "PCMOS386-9-user-patched.img",
    "bj050.img",
    "ibm-exploring.img",
    "hOp-0.8.img",
    "bleskos_2024u32.iso"
)

# Create images directory
New-Item -ItemType Directory -Path "images" -Force | Out-Null

$baseUrl = "https://i.copy.sh/"
$totalFiles = $images.Count
$current = 0
$downloaded = @()
$skipped = @()
$failed = @()

foreach ($image in $images) {
    $current++
    $outputPath = "images/$image"
    
    # Skip if already exists
    if (Test-Path $outputPath) {
        Write-Host "[$current/$totalFiles] Skipping $image (already exists)" -ForegroundColor Yellow
        $skipped += $image
        continue
    }
    
    Write-Host "[$current/$totalFiles] Downloading $image..." -ForegroundColor Cyan
    
    try {
        Invoke-WebRequest -Uri "$baseUrl$image" -OutFile $outputPath -UseBasicParsing -ErrorAction Stop
        $fileSize = (Get-Item $outputPath).Length / 1MB
        Write-Host "  ✓ Downloaded $image ($([math]::Round($fileSize, 2)) MB)" -ForegroundColor Green
        $downloaded += $image
    }
    catch {
        Write-Host "  ✗ Failed to download $image : $_" -ForegroundColor Red
        $failed += $image
        # Clean up failed download
        if (Test-Path $outputPath) {
            Remove-Item $outputPath -Force
        }
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Download Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Downloaded: $($downloaded.Count) files" -ForegroundColor Green
Write-Host "Skipped (existing): $($skipped.Count) files" -ForegroundColor Yellow
Write-Host "Failed: $($failed.Count) files" -ForegroundColor Red

if ($failed.Count -gt 0) {
    Write-Host "`nFailed downloads:" -ForegroundColor Red
    foreach ($img in $failed) {
        Write-Host "  - $img" -ForegroundColor Gray
    }
}

$totalSize = (Get-ChildItem "images" -File | Measure-Object -Property Length -Sum).Sum / 1MB
Write-Host "`nTotal size in images/ folder: $([math]::Round($totalSize, 2)) MB" -ForegroundColor Cyan

Write-Host "`nNext steps for Git LFS:" -ForegroundColor Cyan
Write-Host "  git lfs install" -ForegroundColor White
Write-Host "  git lfs track 'images/*.iso' 'images/*.img' 'images/*.bin' 'images/*.zst'" -ForegroundColor White
Write-Host "  git add .gitattributes images/" -ForegroundColor White
Write-Host "  git commit -m 'Add all OS disk images with Git LFS'" -ForegroundColor White
Write-Host "  git push origin main" -ForegroundColor White
